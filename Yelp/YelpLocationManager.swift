//
//  YelpLocationManager.swift
//  Yelp
//
//  Created by James Zhou on 10/21/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class YelpLocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var currentLocation2D: CLLocationCoordinate2D?
    
    static let sharedInstance = YelpLocationManager()
    
    override init() {
        super.init()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation2D = self.locationManager.location?.coordinate
        print("manager instance: \(manager) updating locations  to = \(self.currentLocation2D?.latitude) \(self.currentLocation2D?.longitude)")
    }
}
