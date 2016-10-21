//
//  BusinessDetailsViewController.swift
//  Yelp
//
//  Created by James Zhou on 10/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessMapViewController: UIViewController {
    
    var mapView: MKMapView?
    
    var coor2D: CLLocationCoordinate2D?
    
    var coorSpan: MKCoordinateSpan?
    
    var business: Business! {
        didSet {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView()
        mapView?.frame = self.view.frame
        mapView?.mapType = .standard
        mapView?.isZoomEnabled = true
        
        let coordinates = business.coordinates
        
        let lat = coordinates?["latitude"]!
        let long = coordinates?["longitude"]!

        coor2D = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        coorSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: coor2D!, span: coorSpan!)
        
        mapView?.setRegion(region, animated: true)
        mapView?.setCenter(coor2D!, animated: true)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coor2D!
        annotation.title = business.name
        
        mapView?.addAnnotation(annotation)
        mapView?.selectAnnotation(annotation, animated: true)
        
        self.view.addSubview(mapView!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let mapsAction = UIPreviewAction(title: "Open Maps App", style: .default) { (previewAction, viewController) in
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: self.coor2D!),
                           MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: self.coorSpan!)]
            
            var theMapPins = [MKMapItem]()
            let placeMark = MKPlacemark(coordinate: self.coor2D!, addressDictionary: nil)
            
            let mapPin = MKMapItem(placemark: placeMark)
            mapPin.name = self.business.name
            
            theMapPins.append(mapPin)

            MKMapItem.openMaps(with: theMapPins, launchOptions: options)
            
        }
        
        let googleAction = UIPreviewAction(title: "Open Google Maps", style: .default) { (previewAction, viewController) in
            
            let lat = self.coor2D!.latitude
            let long = self.coor2D!.longitude
            
            if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
                UIApplication.shared.openURL(URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")!)
            } else {
                print("can't open google maps")
            }
            
        }
        
        return [mapsAction, googleAction]
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
