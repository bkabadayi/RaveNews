//
//  DailySourceItemLayout.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import UIKit

class DailySourceItemLayout: UICollectionViewFlowLayout {
    
    // MARK: - Variables
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth,
                                   height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth,
                          height: itemHeight)
        }
    }
    
    var itemHeight: CGFloat {
        return self.collectionView!.bounds.width
    }
    
    var itemWidth: CGFloat {
        return self.collectionView!.bounds.width - 35
    }
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return self.collectionView!.contentOffset
    }
    
    func setupLayout() {
        self.minimumLineSpacing = 30
        self.scrollDirection = .vertical
        self.sectionInset = UIEdgeInsets(top: 20,
                                         left: 5,
                                         bottom: 0,
                                         right: 5)
    }
}
