//
//  DailySourceItemCell.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 3.07.2023.
//

import UIKit

class DailySourceItemCell: UITableViewCell {

    // MARK: - Variables
    
    @IBOutlet weak var sourceImageView: RaveImageView!
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle  = .none
    }
}
