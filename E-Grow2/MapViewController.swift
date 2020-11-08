//
//  MapViewController.swift
//  E-Grow2
//
//  Created by Kamryn Ohly on 11/7/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var currentLocationString = "Current Location"
    var regionCenter = false
//    var itemAddressArray : [String: String] = [:]
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Recycling centers near me"
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                guard let response = response else {
                    print("There was an error searching for: \(request.naturalLanguageQuery) error: \(error)")
                    return
                }

                for item in response.mapItems {
                    print(item)
//                    self.itemAddressArray[item.name!] = "\(item.placemark)"
                    let mapPoint: MKPointAnnotation = MKPointAnnotation()
                    mapPoint.title = item.name
                    mapPoint.coordinate = item.placemark.coordinate
                    self.mapView.addAnnotation(mapPoint)
                }
            }
        
        let secondRequest = MKLocalSearch.Request()
        secondRequest.naturalLanguageQuery = "Composting"
        secondRequest.region = mapView.region
        let secondSearch = MKLocalSearch(request: secondRequest)
        secondSearch.start { response, error in
            guard let response = response else {
                print("There was an error searching for: \(secondRequest.naturalLanguageQuery) error: \(error)")
                return
            }

            for item in response.mapItems {
                print(item)
//                self.itemAddressArray[item.name!] = "\(item.placemark)"
                let mapPoint: MKPointAnnotation = MKPointAnnotation()
                mapPoint.title = item.name
                mapPoint.coordinate = item.placemark.coordinate
                self.mapView.addAnnotation(mapPoint)
            }
        }
        
       
    }
    
//     func mapView(mapView: MKMapView, didSelectAnnotationView view: MKPointAnnotation)
//    {
//        print(itemAddressArray)
//        if let annotationTitle = view.title
//        {
//            addressLabel.text = itemAddressArray["\(annotationTitle)"]
//            
//        }
//    }
    
    
    //MARK:- CLLocationManagerDelegate Methods
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         
         if !regionCenter {
             let userLocation:CLLocation = locations[0] as CLLocation

             let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
             let regionShown = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.50, longitudeDelta: 0.50))

             mapView.setRegion(regionShown, animated: true)

             let mapPoint: MKPointAnnotation = MKPointAnnotation()
             mapPoint.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
             mapPoint.title = self.setUsersClosestLocation(mLattitude: userLocation.coordinate.latitude, mLongitude: userLocation.coordinate.longitude)
             mapView.addAnnotation(mapPoint)
             regionCenter = true
         }
     
     }
         


 func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
     let geoCoder = CLGeocoder()
     let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

     geoCoder.reverseGeocodeLocation(location) {
         (placemarks, error) -> Void in

         if let userPlace = placemarks{
             if let dictionary = userPlace[0].addressDictionary as? [String: Any]{
                 if let name = dictionary["Name"] as? String{
                     if let city = dictionary["City"] as? String{
                         self.currentLocationString = name + ", " + city
                     }
                 }
             }
         }
     }
     return currentLocationString
 }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
