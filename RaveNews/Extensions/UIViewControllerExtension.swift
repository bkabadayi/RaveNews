//
//  UIViewControllerExtension.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import UIKit

public extension UIViewController {

    /// shows an UIAlertController alert with error title and message
    func showError(_ title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        if !Thread.current.isMainThread {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.showError(title, message: message, handler: handler)
            }
            
            return
        }

        let attributedString = NSAttributedString(string: title,
                                                  attributes: [ .foregroundColor: UIColor.gray])

        let controller = UIAlertController(title: "",
                                           message: "",
                                           preferredStyle: .alert)

        controller.setValue(attributedString, forKey: "attributedTitle")

        if #available(iOS 13.0, *) {
            controller.view.tintColor = .label
        } else {
            controller.view.tintColor = .black
        }

        controller.addAction(UIAlertAction(title: NSLocalizedString("OK",
                                                                    comment: ""),
                                           style: .default,
                                           handler: handler))

        self.present(controller,
                     animated: true,
                     completion: nil)
    }
    
    func showErrorWithDelay(_ title: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.showError(title)
        }
    }
}
