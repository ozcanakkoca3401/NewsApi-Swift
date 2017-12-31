//
//  SourceModel.swift
//  NewsApi
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import Foundation

class SourceModel {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String

    init(id: String, name: String, description:String, url:String, category:String, language:String, country:String) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
}
