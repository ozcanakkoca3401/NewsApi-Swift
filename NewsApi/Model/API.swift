//
//  API.swift
//  NewsApi
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import UIKit
import Alamofire

class API {
    static var baseUrl = "https://newsapi.org"
    static var apiKey = "apiKey=ff2e95214ab84343b6f198aa0b77bc79"
    
    /// Servis çağrısı fonksiyonu
    ///
    /// - Parameters:
    ///   - endPoint: Haber path belirle gibi -> (/v2/sources?)
    ///   - completionhandler: result gelir
    class func makeCall(_ endPoint: String,completionhandler:@escaping (Any) -> ()){
        
        Alamofire.request(baseUrl + endPoint + apiKey).responseJSON { response in
            if let JSON = response.result.value {
                completionhandler(JSON as Any)
            }
        }
    }
}
