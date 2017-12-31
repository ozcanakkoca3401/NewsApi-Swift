//
//  NewsWebViewController.swift
//  NewsApi
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController , WKNavigationDelegate{

    var webView : WKWebView!
    var stringUrl: String?
    
    // ilk olarak view yükle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Safari Open", style: .plain, target: self, action: #selector(openSafari))

        // Webkit kullanarak haber sitesine gir
        let url = URL(string: stringUrl!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    // Safariyi kullanarak haber sitesine gir
    @objc func openSafari() {
        guard let url = URL(string: stringUrl!) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

    }
    
    // Webkit yüklemeye başlayınca
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webView.showHud()
    }
    
    // Webkit yüklemesi bittiğinde
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.hideHud()
    }
    
    
    
}
