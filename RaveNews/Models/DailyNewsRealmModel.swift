//
//  DailyNewsRealmModel.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import Foundation
import RealmSwift

final class DailyNewsRealmModel: Object {
        
    // MARK: - Variables
    
    @objc dynamic var title: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var articleDescription: String = ""
    @objc dynamic var url: String = ""
    
    // MARK: - Methods
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    class func toDailyNewsRealmModel(from dailyNews: DailyNewsModel) -> DailyNewsRealmModel {
        let item = DailyNewsRealmModel()
        item.title = dailyNews.title
        
        if let artDescription = dailyNews.articleDescription {
            item.articleDescription = artDescription
        }
        
        if let writer = dailyNews.author {
            item.author = writer
        }
        
        if let publishedTime = dailyNews.publishedAt {
            item.publishedAt = publishedTime
        }
        
        if let url = dailyNews.url {
            item.url = url
        }
        
        if let imageFromUrl = dailyNews.urlToImage {
            item.urlToImage = imageFromUrl
        }
        
        return item
    }
}
