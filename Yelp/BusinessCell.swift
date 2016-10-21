//
//  BusinessCell.swift
//  Yelp
//
//  Created by James Zhou on 10/19/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var businessNameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet {
            if (business.imageURL != nil) {
                thumbImageView.setImageWith(business.imageURL!)
            }
            if (business.ratingImageURL != nil) {
                ratingImageView.setImageWith(business.ratingImageURL!)
            }
            if (business.reviewCount != nil) {
                reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            }
            if (business.name != nil) {
                businessNameLabel.text = business.name
            }
            if (business.distance != nil) {
                distanceLabel.text = business.distance
            }
            if (business.categories != nil) {
                categoriesLabel.text = business.categories
            }
            if (business.address != nil) {
                addressLabel.text = business.address
            }
            
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        
//        self.businessNameLabel.preferredMaxLayoutWidth = businessNameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.businessNameLabel.preferredMaxLayoutWidth = businessNameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
