//
//  DiningTableViewCell.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 4/26/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class DiningTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let reuseIdentifier = "DiningCell"

    // MARK: -

    @IBOutlet var dayOfWeekLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}