//
//  AddressCell.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/19/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//

import UIKit
import Cosmos

class AddressCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var viewRate: CosmosView!
    @IBOutlet var lblCategoryTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
