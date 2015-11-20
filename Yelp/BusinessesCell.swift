//
//  BusinessesCell.swift
//  Yelp
//
//  Created by HV Fenrir on 11/20/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesCell: UITableViewCell {

    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            thumbImageView.setImageWithURL(business.imageURL!)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            distanLabel.text = business.distance
            rateImageView.setImageWithURL(business.ratingImageURL!)
            reviewsLabel.text =  "\(business.reviewCount!) Reviews"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
