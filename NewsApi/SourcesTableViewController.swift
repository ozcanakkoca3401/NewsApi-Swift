//
//  SourcesTableViewController.swift
//  NewsApi
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import UIKit
import SwiftyJSON
class SourcesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkConnectivityChecking, PopUpPresentable {

    var sourceFullDict : JSON?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 122

        // internet kontrolü
        guard isNetworkConnectivityAvailable() else {
            presentPopUp()
            
            return
        }
        
        self.view.showHud()
        sourceService()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.sourceFullDict?["sources"] == nil {
            return 0
        }
        
        return self.sourceFullDict!["sources"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SourcesTableViewCell
        cell.nameLabel?.text = self.sourceFullDict!["sources"][indexPath.row]["name"].string
        cell.descLabel?.text = self.sourceFullDict!["sources"][indexPath.row]["description"].string
        cell.categoryLabel?.text = self.sourceFullDict!["sources"][indexPath.row]["category"].string
        cell.languageLabel?.text = self.sourceFullDict!["sources"][indexPath.row]["language"].string
        cell.countryLabel?.text = self.sourceFullDict!["sources"][indexPath.row]["country"].string
        
        return cell
    }
    
    // servis çağrısı
    func sourceService() {
        API.makeCall("/v2/sources?"){ (result) in
            self.view.hideHud()
            self.sourceFullDict = JSON(result)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SourceOfNewsId") {
            let row = self.tableView.indexPathForSelectedRow!.row
            let vc = segue.destination as! NewsTableViewController
            vc.newsServiceParameterName = self.sourceFullDict!["sources"][row]["id"].string
            vc.newsName = self.sourceFullDict!["sources"][row]["name"].string

        }
    }



}




