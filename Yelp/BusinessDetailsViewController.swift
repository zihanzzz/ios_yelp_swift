//
//  BusinessDetailsViewController.swift
//  Yelp
//
//  Created by James Zhou on 10/21/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessDetailsViewController: UIViewController {
    
    var business: Business!
    
    @IBOutlet weak var businessImageView: UIImageView!
    
    @IBOutlet weak var businessNameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = business?.name
        
        if (business.imageURL != nil) {
            businessImageView.setImageWith(business.imageURL!)
            
            if !UIAccessibilityIsReduceTransparencyEnabled() {
                let blurEffect = UIBlurEffect(style: .light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = businessImageView.frame
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                businessImageView.addSubview(blurEffectView)
            }
            
        }
        
        if (business.name != nil) {
            businessNameLabel.text = business.name
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
