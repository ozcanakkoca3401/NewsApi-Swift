//
//  SourceFullModel.swift
//  NewsApi
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import Foundation

class SourceFullModel {
    var status: String
    var sources: [SourceModel]
    
    init(status: String, sources: [SourceModel]) {
        self.status = status
        self.sources = sources
    }
}
