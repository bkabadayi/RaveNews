//
//  DailySourceModel.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import Foundation

struct Sources: Codable {
    
    // MARK: - Variables
    
    public let sources: [DailySourceModel]
}

struct DailySourceModel: Codable {
    
    // MARK: - Variables
    
    public let sid: String
    public let name: String
    public let category: String
    public let description: String
    public let isoLanguageCode: String
    public let country: String
    
    private enum CodingKeys: String, CodingKey {
        case sid = "id"
        case name, category, description, country
        case isoLanguageCode = "language"
    }
}
