//
//  NewsTableViewController.swift
//  NewsApi
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class NewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkConnectivityChecking, PopUpPresentable {
    
    var newsFullDict : JSON?
    var newsServiceParameterName: String?
    var newsName: String?
    var timer: DispatchSourceTimer?
    var timerPublishedAt: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // internet kontrolü
        guard isNetworkConnectivityAvailable() else {
            presentPopUp()
            
            return
        }
        
        self.view.showHud()
        self.title = newsName!
        newsService(news: newsServiceParameterName!)
        
        self.tableView.rowHeight = 230
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    // 60 sn'de çalışan timer
    func startTimer() {
        let queue = DispatchQueue(label: "com.domain.app.timer")
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer!.schedule(deadline: .now(), repeating: .seconds(60))
        timer!.setEventHandler {
            if self.timerPublishedAt != nil && self.timerPublishedAt != self.newsFullDict!["articles"][0]["publishedAt"].string {
                self.newsService(news: self.newsServiceParameterName!)
                self.tableView.reloadData()
            }
        }
        timer!.resume()
    }
    
    // timer durdur.
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    deinit {
        self.stopTimer()
    }
    
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.newsFullDict?["articles"] == nil {
            return 0
        }
        
        return self.newsFullDict!["articles"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        

        if indexPath.row == 0 {
            timerPublishedAt = self.newsFullDict!["articles"][indexPath.row]["publishedAt"].string
        }
        if let urlStr = self.newsFullDict!["articles"][indexPath.row]["urlToImage"].string {
            cell.urlImageView.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(named: "not-found"))
        } else {
            cell.urlImageView.image = UIImage(named: "not-found")
        }
        
   
        cell.titleLabel.text = self.newsFullDict!["articles"][indexPath.row]["title"].string
        cell.author.text = self.newsFullDict!["articles"][indexPath.row]["author"].string
        cell.publishedDate.text = self.newsFullDict!["articles"][indexPath.row]["publishedAt"].string
        
        return cell
    }
    
    // servis çağrısı
    func newsService(news: String) {
        API.makeCall("/v2/top-headlines?sources=" + news + "&"){ (result) in
            self.view.hideHud()
            self.newsFullDict = JSON(result)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "WebKitId") {
            let row = self.tableView.indexPathForSelectedRow!.row
            let vc = segue.destination as! NewsWebViewController
            vc.stringUrl = self.newsFullDict!["articles"][row]["url"].string
        }
    }

}
