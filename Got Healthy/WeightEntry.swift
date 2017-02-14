//
//  WeightEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class WeightEntry: UIViewController {
    
    @IBOutlet weak var firstHeightPicker: UIPickerView!
    @IBOutlet weak var firstHeightLabel: UILabel!
    @IBOutlet weak var secondHeightPicker: UIPickerView!
    @IBOutlet weak var secondHeightLabel: UILabel!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        secondHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        weightPicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
}
