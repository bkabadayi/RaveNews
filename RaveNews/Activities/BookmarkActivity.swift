//
//  BookmarkActivity.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 3.07.2023.
//

import UIKit
import RealmSwift

class BookmarkActivity: UIActivity {
    
    // MARK: - Variables
    
    var bookMarkSuccessful: (() -> Void)? = nil
    
    override var activityTitle: String? {
        return "Bookmark"
    }
    
    override var activityImage: UIImage? {
        return R.image.bookmark()
    }
    
    // MARK: - Methods
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for activity in activityItems {
            
            if activity is DailyNewsRealmModel {
                return true
            }
        }
        
        return false
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        for activity in activityItems {
            
            if let activity = activity as? DailyNewsRealmModel {
                let realm = try! Realm()
                
                try! realm.write {
                    realm.add(activity,
                              update: .all)
                    bookMarkSuccessful?()
                }
                
                break
            }
        }
    }
}
