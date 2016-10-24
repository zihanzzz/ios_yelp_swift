//
//  BusinessDetailsViewController.swift
//  Yelp
//
//  Created by James Zhou on 10/21/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailsViewController: UIViewController {
    
    var business: Business!
    
    @IBOutlet weak var businessImageView: UIImageView!
    
    @IBOutlet weak var businessNameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!

    @IBOutlet weak var ratingsImageView: UIImageView!
    
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = business?.name
        
        businessNameLabel.font = UIFont(name: UIConstants.getTextFontNameBold(), size: 20)
        for label in [distanceLabel, reviewsCountLabel, categoriesLabel] {
            label?.font = UIFont(name: UIConstants.getTextFontNameRegular(), size: 17)
        }
        
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
        
        if (business.distance != nil) {
            distanceLabel.text = business.distance
        }
        
        if (business.ratingImageURL != nil) {
            ratingsImageView.setImageWith(business.ratingImageURL!)
        }
        
        if (business.reviewCount != nil) {
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
        }
        
        if (business.categories != nil) {
            categoriesLabel.text = business.categories
        }
        
        if (business.coordinates != nil) {
            let lat = business.coordinates?["latitude"]!
            let long = business.coordinates?["longitude"]!
            
            let coor2D = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            let coorSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            let region = MKCoordinateRegion(center: coor2D, span: coorSpan)
            
            mapView?.setRegion(region, animated: true)
            mapView?.setCenter(coor2D, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coor2D
            annotation.title = business.name
            
            mapView?.addAnnotation(annotation)
            mapView?.selectAnnotation(annotation, animated: true)
            
            
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
