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
        
        selectImageView.image = UIImage(named: "selected")
        selectImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showSelectImage() {
        selectImageView.isHidden = false
    }
    
    func hideSelectImage() {
        selectImageView.isHidden = true
    }

}
