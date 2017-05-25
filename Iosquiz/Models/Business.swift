//
//  Business.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/19/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//

import UIKit

class Business: NSObject {
    var categories = [Dictionary<String, String>]()
    var lat:Double = 0.0
    var long:Double = 0.0
    var id:String = ""
    var display_phone:String = ""
    var distance:String = ""
    var image_url:String = ""
    var is_closed:String = ""
    var state:String = ""
    var display_address:String = ""
    var zip_code:String = ""
    var name:String = ""
    var phone:String = ""
    var price:String = ""
    var rating:Double = 0.0
    var review_count:String = ""
    
    func pupulateBusniesData(busData:AnyObject)  -> Business{
        self.id = (busData as! Dictionary<String,AnyObject>)["id"] as! String
        self.display_phone = (busData as! Dictionary<String,AnyObject>)["display_phone"] as! String
        self.image_url = (busData as! Dictionary<String,AnyObject>)["image_url"] as! String
        self.name = (busData as! Dictionary<String,AnyObject>)["name"] as! String
        self.rating = ((busData as! Dictionary<String,AnyObject>)["rating"]?.doubleValue)!
        self.review_count = ((busData as! Dictionary<String,AnyObject>)["review_count"]?.stringValue)!
        self.categories = (busData as! Dictionary<String,AnyObject>)["categories"] as! Array
        self.lat = (busData as! Dictionary<String,AnyObject>)["coordinates"]?["latitude"] as! Double
        self.long = (busData as! Dictionary<String,AnyObject>)["coordinates"]?["longitude"] as! Double
        self.display_address = (busData as! Dictionary<String,AnyObject>)["location"]?["address1"] as! String
        
        return self
    }
}

