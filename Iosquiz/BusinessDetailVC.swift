//
//  BusinessDetailVC.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/19/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class BusinessDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var business:Business? = nil
    @IBOutlet var headerView: UIView!
    @IBOutlet var tblview: UITableView!
    //   header view Outlets
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var btnCategories: UIButton!
    @IBOutlet var btnInfo: UIButton!
    @IBOutlet var btnRatings: UIButton!
    @IBOutlet var hotelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.tableHeaderView = headerView
        self.title = "Resturant Detail"        
        let url = URL(string: (business?.image_url)!)
        imgProfile.kf.setImage(with: url)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (business?.categories.count)! + 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellG:UITableViewCell? = nil
        if indexPath.row==0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressCell
            cell.lblName.text = business?.name
            cell.lblAddress.text = business?.display_address
            cell.viewRate.rating = (business?.rating)!
            cell.viewRate.text = business?.review_count
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellTitle", for: indexPath) as! categoryCell
            return cell
        } else if indexPath.row > 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! categoryCell
                let dataObj = business?.categories[indexPath.row - 2]
                cell.lblName.text = (dataObj! as Dictionary<String,String>)["title"]
            return cell
        }
        return cellG!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row==0 {
            return 120
        } else if indexPath.row == 1 {
            return 40
        } else if indexPath.row > 1 {
            return 30
        }
        return 120
    }
    @IBAction func reviewsAction(_ sender: Any) {
        let reviewVC = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "reviewVC") as! ReviewVC
        reviewVC.dynamicID = (business?.id)!
        self.navigationController?.pushViewController(reviewVC, animated: true)

    }
}
