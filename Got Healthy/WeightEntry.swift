//
//  WeightEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

var measurmentChosen = ""

class WeightEntry: UIViewController {
    
    @IBOutlet weak var firstHeightPicker: UIPickerView!
    @IBOutlet weak var firstHeightLabel: UILabel!
    @IBOutlet weak var secondHeightPicker: UIPickerView!
    @IBOutlet weak var secondHeightLabel: UILabel!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var measurementSwitchChoice: UISegmentedControl!

    let meterFirst = ["0", "1", "2", "3"]
    
    let meterExact = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        secondHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        weightPicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
        @IBAction func measurementChoice(_ sender: Any) {
            switch measurementSwitchChoice.selectedSegmentIndex {
            case 0:
                firstHeightLabel.text = "FT"
                secondHeightLabel.text = "IN"
                weightLabel.text = "LBS"
            case 1:
                firstHeightLabel.text = "."
                secondHeightLabel.text = "M"
                weightLabel.text = "KG"
            default:
                break
            }
    }
    
    @IBAction func getHealthyPressed(_ sender: Any) {
        measurmentChosen = measurementSwitchChoice.titleForSegment(at: measurementSwitchChoice.selectedSegmentIndex)!
    }
}
