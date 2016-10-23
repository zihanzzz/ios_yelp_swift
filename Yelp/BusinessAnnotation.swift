//
//  BusinessAnnotation.swift
//  Yelp
//
//  Created by James Zhou on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessAnnotation: NSObject, MKAnnotation {

    var business: Business!
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(business: Business) {
        self.business = business
        let lat = business.coordinates?["latitude"]!
        let long = business.coordinates?["longitude"]!
        self.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        self.title = business.name
        self.subtitle = business.address
        super.init()
    }
}
