//
//  ChoiceCell.swift
//  Yelp
//
//  Created by James Zhou on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class ChoiceCell: UITableViewCell {

    @IBOutlet weak var choiceLabel: UILabel!
    
    @IBOutlet weak var selectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectImageView.isHidden = true
        self.choiceLabel.textColor = UIConstants.yelpDarkRed
        self.choiceLabel.font = UIFont(name: UIConstants.getTextFontName(), size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showDealSelectedImage() {
        selectImageView.image = UIImage(named: "deal_selected")
        selectImageView.isHidden = false
    }
    
    func showDealDeselectedImage() {
        selectImageView.image = UIImage(named: "deal_deselected")
        selectImageView.isHidden = false
    }
    
    func showSelectImage() {
        selectImageView.image = UIImage(named: "selected")
        selectImageView.isHidden = false
    }
    
    func showCategoryImage() {
        selectImageView.image = UIImage(named: "category")
        selectImageView.isHidden = false
    }
    
    func hideSelectImage() {
        selectImageView.isHidden = true
    }
    
    

}
