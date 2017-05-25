//
//  ReviewCell.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/25/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCell: UITableViewCell {

    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var viewRating: CosmosView!
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var textViewReview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
