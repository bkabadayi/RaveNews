//
//  NewsSourceParameters.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import Foundation

struct NewsSourceParameters {
    
    // MARK: - Variables
    
    let category: String?
    let language: String?
    let country: String?
    
    // MARK: - Initializers
    
    init(category: String? = nil, language: String? = nil, country: String? = nil) {
        self.category = category
        self.language = language
        self.country = country
    }
}
