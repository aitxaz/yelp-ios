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
    var didchangePos:Bool = false
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var viewMap: UIView!
    var lat:Double = 0.0
    var long:Double = 0.0
    
    var camera:GMSCameraPosition? = nil
    var mapView:GMSMapView? = nil
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.title = "Resturants"
//        lat = 37.786882
//        long = -122.399972
        NetworkLayer.sharedInstance.delegate = self
        self.initializeTheLocationManager()
        
        lat = (locationManager.location?.coordinate.latitude)!
        long = (locationManager.location?.coordinate.longitude)!
        
        camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
        mapView?.delegate = self
        view = mapView
    
        NetworkLayer.sharedInstance.getBusinesses(lat: Float(lat), long: Float(long))
    }
    override func viewWillAppear(_ animated: Bool) {
        NetworkLayer.sharedInstance.delegate = self
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
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if didchangePos {
            let latitude:Double = mapView.camera.target.latitude
            let longitude:Double = mapView.camera.target.longitude
            lat = latitude
            long = longitude
            NetworkLayer.sharedInstance.getBusinesses(lat:Float(latitude),long: Float(longitude))
            didchangePos = false
        }
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        didchangePos = true
    }
    func loadmap(arr:NSMutableArray) {
                businessArr = arr
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
    func getResponse(arr:NSMutableArray) {
        self.loadmap(arr: arr)
    }
}
