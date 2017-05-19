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
    var display_phone:String = ""
    var distance:String = ""
    var id:String = ""
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
}
