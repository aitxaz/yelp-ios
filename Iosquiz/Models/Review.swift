
//  Review.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/25/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//

import UIKit

class Review: NSObject {
    var url:String = ""
    var text:String = ""
    var rating:Double = 0.0
    var image_url:Any? = nil
    var name:String = ""
    var time_created:String = ""
    
    func populateReviewData(reviewData:AnyObject) -> Review {
        print(reviewData)
        self.url = (reviewData as! Dictionary<String,AnyObject>)["url"] as! String
        self.text = (reviewData as! Dictionary<String,AnyObject>)["text"] as! String
            self.rating = ((reviewData as! Dictionary<String,AnyObject>)["rating"]?.doubleValue)!
        
        if (reviewData as! Dictionary<String,AnyObject>)["user"]?["image_url"] is NSNull{
            self.image_url = ""
        }else{
            self.image_url = (reviewData as! Dictionary<String,AnyObject>)["user"]?["image_url"] as! String
        }
        self.time_created = (reviewData as! Dictionary<String,AnyObject>)["time_created"] as! String
        self.name = (reviewData as! Dictionary<String,AnyObject>)["user"]?["name"] as! String
        
        return self
    }
}
