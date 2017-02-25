//
//  WeightEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

var measurmentChosen = ""

class WeightEntry: UIViewController, UIPickerViewDelegate {
    
    let weightDefaults = UserDefaults.standard
    
    @IBOutlet weak var firstHeightPicker: UIPickerView!
    @IBOutlet weak var firstHeightLabel: UILabel!
    @IBOutlet weak var secondHeightPicker: UIPickerView!
    @IBOutlet weak var secondHeightLabel: UILabel!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var measurementSwitchChoice: UISegmentedControl!
    
    var firstHeightChosen = ""
    var secondHeightChosen = ""
    var weightChosen = ""

    let feetFirst = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    let inches = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    
    let meterFirst = ["0", "1", "2", "3"]
    
    let meterExact = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
    
    let pounds = [79..<401]
    
    let pounds1 = ["80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199"]
    
    let kilograms = ["22"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        secondHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        weightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        firstHeightPicker.delegate = self
        secondHeightPicker.delegate = self
        weightPicker.delegate = self
        print(measurementSwitchChoice.selectedSegmentIndex)
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
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            firstHeightChosen = feetFirst[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            firstHeightChosen = feetFirst[row]
        }
        return feetFirst[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0 {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = feetFirst[row]
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 18)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
        }
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = feetFirst[row]
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 18)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            return feetFirst.count
        }
        return feetFirst.count
    }
}
