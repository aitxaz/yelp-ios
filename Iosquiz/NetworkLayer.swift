//
//  NetworkLayer.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/19/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//


protocol NetworkDelegate {
    func updatePins(arr:NSMutableArray)
}

import UIKit
import Alamofire

class NetworkLayer: NSObject {

    
    static let sharedInstance = NetworkLayer()
    var delegate:NetworkDelegate?

    
    func getBusinesses(lat:Float,long:Float) {
        
        let businessArr:NSMutableArray = []
        
//        Alamofire.request("https://api.yelp.com/v3/businesses/search?term=restaurants&latitude=\(lat)&longitude=\(long)").responseJSON
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer f-Oezj8VaCmOWl1DI2EjqjSvtYLQl0WkyULF38necT09bfhehzjjsSEqMUNgs2TLIC7a1zT4ExXohDK5EmVu3mVBXzbpzyA5ccdNNrycf48LR6tN4ZeWljXHSpUeWXYx",
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://api.yelp.com/v3/businesses/search?term=restaurants&latitude=\(lat)&longitude=\(long)", headers: headers).responseJSON { response in
            
            
            if case let JSON as Dictionary<String, Any> = response.result.value {
                print("JSON: \(JSON["businesses"])")

                
                if case let business as Array<Any> = JSON["businesses"] {
                    if (business.count > 0) {
                                for index in 0...business.count - 1 {
                                    let dataObj = business[index]
                                    let bus = Business()
                                    bus.display_phone = (dataObj as! Dictionary<String,AnyObject>)["display_phone"] as! String
                                    bus.image_url = (dataObj as! Dictionary<String,AnyObject>)["image_url"] as! String
                                    bus.name = (dataObj as! Dictionary<String,AnyObject>)["name"] as! String
                                    bus.rating = ((dataObj as! Dictionary<String,AnyObject>)["rating"]?.doubleValue)!
                                    bus.review_count = ((dataObj as! Dictionary<String,AnyObject>)["review_count"]?.stringValue)!
                                    bus.categories = (dataObj as! Dictionary<String,AnyObject>)["categories"] as! Array
                                    
                                    bus.lat = (dataObj as! Dictionary<String,AnyObject>)["coordinates"]?["latitude"] as! Double
                                    bus.long = (dataObj as! Dictionary<String,AnyObject>)["coordinates"]?["longitude"] as! Double
                                    
                                    bus.display_address = (dataObj as! Dictionary<String,AnyObject>)["location"]?["address1"] as! String
                                    
                                    businessArr.add(bus)
                                    
                                }
                                //                        print(businessArr)
                                
                            }
                            self.delegate?.updatePins(arr:businessArr)
                            
                        }
                
                    }
//                for business in JSON {
//                    print(business)
//                }
//
//            }
        }

    }
}
