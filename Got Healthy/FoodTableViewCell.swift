//
//  FoodTableViewCell.swift
//  menu
//
//  Created by Aliya Gangji on 4/14/17.
//  Copyright © 2017 Aliya Gangji. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
