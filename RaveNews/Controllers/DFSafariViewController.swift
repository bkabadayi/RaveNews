//
//  DFSafariViewController.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 3.07.2023.
//

import UIKit
import SafariServices

class DFSafariViewController: SFSafariViewController {
    
    // MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.preferredControlTintColor = .label
        } else {
            self.preferredControlTintColor = .black
        }
    }
}
