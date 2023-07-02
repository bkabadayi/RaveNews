//
//  RaveImageView.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import UIKit
import Kingfisher

class RaveImageView: UIImageView {
    func downloadedFromLink(_ urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: urlString) else { return }
        
        self.contentMode = mode
        self.kf.setImage(with: url,
                         options: [.transition(.fade(0.4)),
                                   .cacheOriginalImage])
        
        self.animateImageAppearance(0.4,
                                    option: .curveEaseOut,
                                    alpha: 1.0)
    }
    
    //Helper for Image Appear Animation
    fileprivate func animateImageAppearance(_ duration: Double, option: UIView.AnimationOptions, alpha: CGFloat) {
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: option,
                       animations: { self.alpha = alpha },
                       completion: nil)
    }
}
