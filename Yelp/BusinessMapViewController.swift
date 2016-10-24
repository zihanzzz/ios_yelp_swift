//
//  BusinessDetailsViewController.swift
//  Yelp
//
//  Created by James Zhou on 10/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessMapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView?
    
    var isPreview: Bool = false
    
    var previewName: String?
    
    var previewCoor2D: CLLocationCoordinate2D?
    
    var previewCoorSpan: MKCoordinateSpan?
    
    var businesses: [Business]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConstants.configureNavBarStyle(forViewController: self)
        
        mapView = MKMapView()
        mapView?.frame = self.view.frame
        mapView?.mapType = .standard
        mapView?.isZoomEnabled = true
        
        if (!isPreview) {
            mapView?.delegate = self
        }
        
        var annotations = [BusinessAnnotation]()
        
        for business in businesses {
            let annotation = BusinessAnnotation(business: business)
            annotations.append(annotation)
        }
        
        mapView?.addAnnotations(annotations)
        mapView?.showAnnotations(annotations, animated: true)
        mapView?.selectAnnotation(annotations[0], animated: true)
        
        if (isPreview) {
            let businessAnnotation = annotations[0]
            let business = businessAnnotation.business
            previewName = business?.name
            previewCoor2D = businessAnnotation.coordinate
            previewCoorSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            mapView?.setCenter(businessAnnotation.coordinate, animated: true)
        }

        self.view.addSubview(mapView!)
    }
    
    @IBAction func listButtonTapped(_ sender: AnyObject) {
        self.modalTransitionStyle = .flipHorizontal
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        
        
        let mapsAction = UIPreviewAction(title: "Open Maps App", style: .default) { (previewAction, viewController) in
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: self.previewCoor2D!),
                           MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: self.previewCoorSpan!)]
            
            var theMapPins = [MKMapItem]()
            let placeMark = MKPlacemark(coordinate: self.previewCoor2D!, addressDictionary: nil)
            
            let mapPin = MKMapItem(placemark: placeMark)
            mapPin.name = self.previewName
            
            theMapPins.append(mapPin)
            MKMapItem.openMaps(with: theMapPins, launchOptions: options)
        }
        
        let googleAction = UIPreviewAction(title: "Open Google Maps", style: .default) { (previewAction, viewController) in
            
            let lat = self.previewCoor2D!.latitude
            let long = self.previewCoor2D!.longitude

            if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
                UIApplication.shared.openURL(URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")!)
            } else {
                print("can't open google maps")
            }
        }
        
        let yelpAction = UIPreviewAction(title: "Open in Yelp", style: .default) { (previewAction, viewController) in
            
            let business = self.businesses[0]
            let businessId = business.bizId
            let bizURL = "yelp:///biz/" + businessId!
            
            if (UIApplication.shared.canOpenURL(URL(string: "yelp:")!)) {
                UIApplication.shared.openURL(URL(string: bizURL)!)
            } else {
                print("can't open yelp")
            }
        }
        
        let callAction = UIPreviewAction(title: "Call Business", style: .default) { (previewAction, viewController) in
            let business = self.businesses[0]
            let urlString = "tel://" + business.phone!
            
            if let url = URL(string: urlString) {
                UIApplication.shared.openURL(url)
            } else {
                print("can't call business")
            }
        }
        
        let dismissAction = UIPreviewAction(title: "Cancel", style: .default) { (previewAction, viewController) in
            self.dismiss(animated: true, completion: nil)
        }
        
        return [mapsAction, googleAction, yelpAction, callAction, dismissAction]
    }
    
    // MARK : - MKMapView delegate methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .infoLight)
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let businessAnnotation = view.annotation as! BusinessAnnotation
        let business = businessAnnotation.business
        let businessDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "Business Details") as! BusinessDetailsViewController
        businessDetailsViewController.business = business
        self.navigationController?.pushViewController(businessDetailsViewController, animated: true)
    }
}
