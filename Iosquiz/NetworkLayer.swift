//
//  NetworkLayer.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/19/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//


@objc protocol NetworkDelegate {
    @objc optional func getResponse(arr:NSMutableArray)
    @objc optional func getReviewsResponse(arr:NSMutableArray)

}

import UIKit
import Alamofire

class NetworkLayer: NSObject {

    
    static let sharedInstance = NetworkLayer()
    var delegate:NetworkDelegate?

    
    func getBusinesses(lat:Float,long:Float) {
        
        let businessArr:NSMutableArray = []
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
                                    businessArr.add(bus.pupulateBusniesData(busData: dataObj as AnyObject))
                                }
                            }
                            self.delegate?.getResponse!(arr:businessArr)
                            
                        }
                    }
        }

    }
    
    func getReviews(id:String){
        let arrReviews:NSMutableArray = []
        let headers: HTTPHeaders = [
            "Authorization": "Bearer f-Oezj8VaCmOWl1DI2EjqjSvtYLQl0WkyULF38necT09bfhehzjjsSEqMUNgs2TLIC7a1zT4ExXohDK5EmVu3mVBXzbpzyA5ccdNNrycf48LR6tN4ZeWljXHSpUeWXYx",
            "Accept": "application/json"
        ]

        Alamofire.request("https://api.yelp.com/v3/businesses/\(id)/reviews", headers: headers).responseJSON { response in
            if case let JSON as Dictionary<String, Any> = response.result.value {
                print("JSON: \(JSON["reviews"])")
                
                
                if case let reviews as Array<Any> = JSON["reviews"] {
                    if (reviews.count > 0) {
                        for index in 0...reviews.count - 1 {
                            let reviewObj = reviews[index]
                            let review = Review()
                            arrReviews.add(review.populateReviewData(reviewData: reviewObj as AnyObject))
                        }
                    }
                    self.delegate?.getReviewsResponse!(arr:arrReviews)
                }
            }
        }
    }
}
