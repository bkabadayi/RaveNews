//
//  DailyNewsModel.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import Foundation
import UniformTypeIdentifiers

// MARK: - Enums

enum DailyNewsModelUTI {
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

final class DailyNewsModel: NSObject, Serializable {
    
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

extension DailyNewsModel: NSItemProviderWriting {
    
    static var writableTypeIdentifiersForItemProvider: [String] = [DailyNewsModelUTI.kUUTTypeDailyFeedModel, UTType.utf8PlainText.identifier as String]
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        if typeIdentifier == DailyNewsModelUTI.kUUTTypeDailyFeedModel {
            completionHandler(self.serialize(), nil)
        } else if typeIdentifier == UTType.utf8PlainText.identifier {
            completionHandler(self.url?.data(using: .utf8), nil)
        } else {
            completionHandler(nil, DailyFeedModelError.invalidDailyFeedModel)
        }
        return nil
    }
}

extension DailyNewsModel: NSItemProviderReading {
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [DailyNewsModelUTI.kUUTTypeDailyFeedModel]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> DailyNewsModel {
        if typeIdentifier == DailyNewsModelUTI.kUUTTypeDailyFeedModel {
            let dfm = DailyNewsModel()
            do {
                let dailyFeedModel = try dfm.deserialize(data: data)
                return dailyFeedModel
            } catch {
                throw DailyFeedModelError.invalidDailyFeedModel
            }
        } else {
            throw DailyFeedModelError.invalidTypeIdentifier
        }
    }
}

