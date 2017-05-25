//
//  ReviewVC.swift
//  Iosquiz
//
//  Created by RCAPPS on 5/25/17.
//  Copyright © 2017 RCAPPS. All rights reserved.
//

import UIKit
import Cosmos

class ReviewVC: UITableViewController,NetworkDelegate{
    var restID:String = ""
    var dynamicID = ""
    
    var arrReviews:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        print(dynamicID)
        restID = dynamicID
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 115
        NetworkLayer.sharedInstance.getReviews(id:restID)
    }
    override func viewWillAppear(_ animated: Bool) {
        NetworkLayer.sharedInstance.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrReviews.count >= 0{
            return (arrReviews.count)
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let review = arrReviews[indexPath.row] as! Review
       
        if review.image_url as! String == "" {
            
        }else{
            let url:URL? = URL(string:(review.image_url as? String)!)
            cell.imgProfile.kf.setImage(with:url)

        }
        
        cell.lblName.text = review.name
        cell.viewRating.rating = (review.rating)
        cell.textViewReview.text = review.text
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
// MARK:network Delegate
    func getReviewsResponse(arr:NSMutableArray) {
        arrReviews = arr
        self.tableView.reloadData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        arrReviews.removeAllObjects()
    }
}
