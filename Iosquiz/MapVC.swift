//
//  MapVC.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/19/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//

import UIKit
import GoogleMaps
import LocalAuthentication


class MapVC: UIViewController,NetworkDelegate,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    var businessArr:NSMutableArray = []
    var locationManager = CLLocationManager()
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var viewMap: UIView!
    var lat:Double = 0.0
    var long:Double = 0.0
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.title = "Resturants"
//        lat = 37.786882
//        long = -122.399972
        NetworkLayer.sharedInstance.delegate = self
        self.initializeTheLocationManager()
        lat = (locationManager.location?.coordinate.latitude)!
        long = (locationManager.location?.coordinate.longitude)!
        
        
        print(lat)
        NetworkLayer.sharedInstance.getBusinesses(lat: Float(lat), long: Float(long))
        
        
        
    }
    func initializeTheLocationManager()
    {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        } else {
            print("Location services are not enabled");
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
//        if ((error) != nil) {
            print(error)
//        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        let locationArray = locations as NSArray
//        let locationObj = locationArray.lastObject as! CLLocation
//        let coord = locationObj.coordinate
//        print(coord)
        
        lat = (manager.location?.coordinate.latitude)!
        long = (manager.location?.coordinate.longitude)!
        NetworkLayer.sharedInstance.getBusinesses(lat: Float(lat), long: Float(long))

//        longitude.text = coord.longitude
//        latitude.text = coord.latitude
//        longitude.text = "\(coord.longitude)"
//        latitude.text = "\(coord.latitude)"
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//        manager.location?.coordinate.latitude
        lat = (manager.location?.coordinate.latitude)!
        long = (manager.location?.coordinate.longitude)!
        NetworkLayer.sharedInstance.getBusinesses(lat: Float(lat), long: Float(long))

    }
    func loadmap(arr:NSMutableArray) {
                businessArr = arr
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
                let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
       
     ///   if let mylocation = mapView.myLocation {
   //         print("User's location: \(mylocation)")
//} else {
    //        print("User's location is unknown")
   //     }

        mapView.delegate = self
                view = mapView
        
        if arr.count > 0 {
            for index in 0...arr.count-1 {
                
                let business = arr[index] as! Business
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude:business.lat, longitude: business.long)
                marker.title = business.name
                marker.userData = index
                marker.snippet = "\(business.display_address) \n Ratings: \(business.rating)"
                marker.map = mapView
                
            }
        }
        
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! BusinessDetailVC
        detail.business = businessArr[marker.userData as! Int] as? Business
        self.navigationController?.pushViewController(detail, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func updatePins(arr:NSMutableArray) {
        self.loadmap(arr: arr)
    }
}
