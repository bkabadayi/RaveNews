//
//  DailyNewsModel.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import Foundation
import MobileCoreServices

// MARK: - Enums

enum DailyFeedModelUTI {
    static let kUUTTypeDailyFeedModel = "kUUTTypeDailyFeedModel"
}

enum DailyFeedModelError: Error {
    case invalidTypeIdentifier
    case invalidDailyFeedModel
}

struct Articles: Codable {
    
    // MARK: - Variables
    
    var articles: [DailyNewsModel]
}

final class DailyNewsModel: NSObject, Codable {
    
    // MARK: - Variables
    
    public var title: String = ""
    public var author: String?
    public var publishedAt: String?
    public var urlToImage: String?
    public var articleDescription: String?
    public var url: String?
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case articleDescription = "description"
        case title, author, publishedAt, urlToImage, url
    }
}
