//
//  WeightEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

var measurmentChosen = ""
var firstHeightMeasurement = ""
var secondHeightMeasurement = ""
var weightMeasurement = ""

class WeightEntry: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var firstHeightPicker: UIPickerView!
    @IBOutlet weak var metricHeightPicker: UIPickerView!
    @IBOutlet weak var firstHeightLabel: UILabel!
    @IBOutlet weak var secondHeightPicker: UIPickerView!
    @IBOutlet weak var secondMetricPicker: UIPickerView!
    @IBOutlet weak var secondHeightLabel: UILabel!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var metricWeightPicker: UIPickerView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var measurementSwitchChoice: UISegmentedControl!
    let heightWeightDefaults = UserDefaults.standard
    
    var firstHeightChosen = ""
    var firstHeightRowChosen = 0
    var firstHeightChosenMetric = ""
    var firstHeightRowChosenMetric = 0
    var secondHeightChosen = ""
    var secondHeightRowChosen = 0
    var secondHeightChosenMetric = ""
    var secondHeightRowChosenMetric = 0
    var weightChosen = ""
    var weightRowChosen = 0
    var weightChosenMetric = ""
    var weightRowChosenMetric = 0
    var middleOfPickerHeight = 0
    var middleOfPickerSecondHeight = 0
    var middleOfPickerWeight = 0
    var middleOfPickerHeightMetric = 0
    var middleOfPickerSecondHeightMetric = 0
    var middleOfPickerWeightMetric = 0

    let feetFirst = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    let inches = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    
    let meterFirst = ["0", "1", "2", "3"]
    
    let meterExact = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
    
    let pounds = ["80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "270", "271", "272", "273", "274", "275", "276", "277", "278", "279", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", "292", "293", "294", "295", "296", "297", "298", "299", "300", "301", "302", "303", "304", "305", "306", "307", "308", "309", "310", "311", "312", "313", "314", "315", "316", "317", "318", "319", "320", "321", "322", "323", "324", "325", "326", "327", "328", "329", "330", "331", "332", "333", "334", "335", "336", "337", "338", "339", "340", "341", "342", "343", "344", "345", "346", "347", "348", "349", "350", "351", "352", "353", "354", "355", "356", "357", "358", "359", "360", "361", "362", "363", "364", "365", "366", "367", "368", "369", "370", "371", "372", "373", "374", "375", "376", "377", "378", "379", "380", "381", "382", "383", "384", "385", "386", "387", "388", "389", "390", "391", "392", "393", "394", "395", "396", "397", "398", "399", "400"]
    
    let kilograms = ["36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181"]
    
    func pickerChange() {
        self.firstHeightPicker.reloadAllComponents()
        self.secondHeightPicker.reloadAllComponents()
        self.weightPicker.reloadAllComponents()
        self.metricHeightPicker.reloadAllComponents()
        self.secondMetricPicker.reloadAllComponents()
        self.metricWeightPicker.reloadAllComponents()
        if let firstHeightStoredBefore = heightWeightDefaults.object(forKey: "firstHeightRowChosen"){
            self.firstHeightPicker.selectRow(firstHeightStoredBefore as! Int, inComponent: 0, animated: true)
            self.pickerView(firstHeightPicker, didSelectRow: firstHeightStoredBefore as! Int, inComponent: 0)
        }
        else {
            middleOfPickerHeight = feetFirst.count / 2
            self.firstHeightPicker.selectRow(middleOfPickerHeight, inComponent: 0, animated: true)
            self.pickerView(firstHeightPicker, didSelectRow: middleOfPickerHeight, inComponent: 0)
        }
        if let secondHeightStoredBefore = heightWeightDefaults.object(forKey: "secondHeightRowChosen"){
            self.secondHeightPicker.selectRow(secondHeightStoredBefore as! Int, inComponent: 0, animated: true)
            self.pickerView(secondHeightPicker, didSelectRow: secondHeightStoredBefore as! Int, inComponent: 0)
        }
        else{
            middleOfPickerSecondHeight = inches.count / 2
            self.secondHeightPicker.selectRow(middleOfPickerSecondHeight, inComponent: 0, animated: true)
            self.pickerView(secondHeightPicker, didSelectRow: middleOfPickerSecondHeight, inComponent: 0)
        }
        if let weightStoredBefore = heightWeightDefaults.object(forKey: "weightRowChosen"){
            self.weightPicker.selectRow(weightStoredBefore as! Int, inComponent: 0, animated: true)
            self.pickerView(weightPicker, didSelectRow: weightStoredBefore as! Int, inComponent: 0)
        }
        else{
            middleOfPickerWeight = pounds.count / 2
            self.weightPicker.selectRow(middleOfPickerWeight, inComponent: 0, animated: true)
            self.pickerView(weightPicker, didSelectRow: middleOfPickerWeight, inComponent: 0)
        }
        if let metricHeightStoredBefore = heightWeightDefaults.object(forKey: "firstHeightRowChosenMetric"){
            self.metricHeightPicker.selectRow(metricHeightStoredBefore as! Int, inComponent: 0, animated: true)
            self.pickerView(metricHeightPicker, didSelectRow: metricHeightStoredBefore as! Int, inComponent: 0)
        }
        else{
            middleOfPickerHeightMetric = meterFirst.count / 2
            self.metricHeightPicker.selectRow(middleOfPickerHeightMetric, inComponent: 0, animated: true)
            self.pickerView(metricHeightPicker, didSelectRow: middleOfPickerHeightMetric, inComponent: 0)
        }
        if let secondMetricHeightStoredBefore = heightWeightDefaults.object(forKey: "secondHeightRowChosenMetric"){
            self.secondMetricPicker.selectRow(secondMetricHeightStoredBefore as! Int, inComponent: 0, animated: true)
            self.pickerView(secondMetricPicker, didSelectRow: secondMetricHeightStoredBefore as! Int, inComponent: 0)
        }
        else{
            middleOfPickerSecondHeightMetric = meterExact.count / 2
            self.metricHeightPicker.selectRow(middleOfPickerSecondHeightMetric, inComponent: 0, animated: true)
            self.pickerView(secondMetricPicker, didSelectRow: middleOfPickerSecondHeightMetric, inComponent: 0)
        }
        if let weightMetricStoredBefore = heightWeightDefaults.object(forKey: "weightRowChosenMetric"){
            self.metricWeightPicker.selectRow(weightMetricStoredBefore as! Int, inComponent: 0, animated: true)
            self.pickerView(metricWeightPicker, didSelectRow: weightMetricStoredBefore as! Int, inComponent: 0)
        }
        else{
            middleOfPickerWeightMetric = kilograms.count / 2
            self.metricWeightPicker.selectRow(middleOfPickerWeightMetric, inComponent: 0, animated: true)
            self.pickerView(metricWeightPicker, didSelectRow: middleOfPickerWeightMetric, inComponent: 0)
        }
        self.firstHeightPicker.reloadAllComponents()
        self.secondHeightPicker.reloadAllComponents()
        self.weightPicker.reloadAllComponents()
        self.metricHeightPicker.reloadAllComponents()
        self.secondMetricPicker.reloadAllComponents()
        self.metricWeightPicker.reloadAllComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.statusBarStyle = .lightContent
        firstHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        secondHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        weightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        metricHeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        secondMetricPicker.setValue(UIColor.white, forKeyPath: "textColor")
        metricWeightPicker.setValue(UIColor.white, forKeyPath: "textColor")
        firstHeightPicker.delegate = self
        secondHeightPicker.delegate = self
        weightPicker.delegate = self
        metricHeightPicker.delegate = self
        secondMetricPicker.delegate = self
        metricWeightPicker.delegate = self
        //firstHeightPicker.
        if measurementSwitchChoice.selectedSegmentIndex == 0{
            firstHeightLabel.text = "FT"
            firstHeightLabel.font = firstHeightLabel.font.withSize(26)
            secondHeightLabel.text = "IN"
            weightLabel.text = "LBS"
            pickerChange()
            firstHeightPicker.isHidden = false
            self.firstHeightPicker.reloadAllComponents()
            secondHeightPicker.isHidden = false
            self.secondHeightPicker.reloadAllComponents()
            weightPicker.isHidden = false
            self.weightPicker.reloadAllComponents()
            metricHeightPicker.isHidden = true
            self.metricHeightPicker.reloadAllComponents()
            secondMetricPicker.isHidden = true
            self.secondMetricPicker.reloadAllComponents()
            metricWeightPicker.isHidden = true
            self.metricWeightPicker.reloadAllComponents()
        }
        if measurementSwitchChoice.selectedSegmentIndex == 1{
            firstHeightLabel.text = "."
            firstHeightLabel.font = firstHeightLabel.font.withSize(60)
            secondHeightLabel.text = "M"
            weightLabel.text = "KG"
            pickerChange()
            metricHeightPicker.isHidden = false
            self.metricHeightPicker.reloadAllComponents()
            secondMetricPicker.isHidden = false
            self.secondMetricPicker.reloadAllComponents()
            metricWeightPicker.isHidden = false
            self.metricWeightPicker.reloadAllComponents()
            firstHeightPicker.isHidden = true
            self.firstHeightPicker.reloadAllComponents()
            secondHeightPicker.isHidden = true
            self.secondHeightPicker.reloadAllComponents()
            weightPicker.isHidden = true
            self.weightPicker.reloadAllComponents()
        }
        
        if let measurementChoiceBefore = heightWeightDefaults.string(forKey: "measurementChoiceEntered") {
            measurementSwitchChoice.selectedSegmentIndex = Int(measurementChoiceBefore)!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if measurementSwitchChoice.selectedSegmentIndex == 0{
            firstHeightLabel.text = "FT"
            firstHeightLabel.font = firstHeightLabel.font.withSize(26)
            secondHeightLabel.text = "IN"
            weightLabel.text = "LBS"
            pickerChange()
            firstHeightPicker.isHidden = false
            self.firstHeightPicker.reloadAllComponents()
            secondHeightPicker.isHidden = false
            self.secondHeightPicker.reloadAllComponents()
            weightPicker.isHidden = false
            self.weightPicker.reloadAllComponents()
            metricHeightPicker.isHidden = true
            self.metricHeightPicker.reloadAllComponents()
            secondMetricPicker.isHidden = true
            self.secondMetricPicker.reloadAllComponents()
            metricWeightPicker.isHidden = true
            self.metricWeightPicker.reloadAllComponents()
        }
        if measurementSwitchChoice.selectedSegmentIndex == 1{
            firstHeightLabel.text = "."
            firstHeightLabel.font = firstHeightLabel.font.withSize(60)
            secondHeightLabel.text = "M"
            weightLabel.text = "KG"
            pickerChange()
            metricHeightPicker.isHidden = false
            self.metricHeightPicker.reloadAllComponents()
            secondMetricPicker.isHidden = false
            self.secondMetricPicker.reloadAllComponents()
            metricWeightPicker.isHidden = false
            self.metricWeightPicker.reloadAllComponents()
            firstHeightPicker.isHidden = true
            self.firstHeightPicker.reloadAllComponents()
            secondHeightPicker.isHidden = true
            self.secondHeightPicker.reloadAllComponents()
            weightPicker.isHidden = true
            self.weightPicker.reloadAllComponents()
        }
    }
    
        @IBAction func measurementChoice(_ sender: Any) {
            switch measurementSwitchChoice.selectedSegmentIndex {
            case 0:
                firstHeightLabel.text = "FT"
                firstHeightLabel.font = firstHeightLabel.font.withSize(26)
                secondHeightLabel.text = "IN"
                weightLabel.text = "LBS"
                pickerChange()
                firstHeightPicker.isHidden = false
                self.firstHeightPicker.reloadAllComponents()
                secondHeightPicker.isHidden = false
                self.secondHeightPicker.reloadAllComponents()
                weightPicker.isHidden = false
                self.weightPicker.reloadAllComponents()
                metricHeightPicker.isHidden = true
                self.metricHeightPicker.reloadAllComponents()
                secondMetricPicker.isHidden = true
                self.secondMetricPicker.reloadAllComponents()
                metricWeightPicker.isHidden = true
                self.metricWeightPicker.reloadAllComponents()

            case 1:
                firstHeightLabel.text = "."
                firstHeightLabel.font = firstHeightLabel.font.withSize(60)
                secondHeightLabel.text = "M"
                weightLabel.text = "KG"
                pickerChange()
                metricHeightPicker.isHidden = false
                self.metricHeightPicker.reloadAllComponents()
                secondMetricPicker.isHidden = false
                self.secondMetricPicker.reloadAllComponents()
                metricWeightPicker.isHidden = false
                self.metricWeightPicker.reloadAllComponents()
                firstHeightPicker.isHidden = true
                self.firstHeightPicker.reloadAllComponents()
                secondHeightPicker.isHidden = true
                self.secondHeightPicker.reloadAllComponents()
                weightPicker.isHidden = true
                self.weightPicker.reloadAllComponents()
            default:
                break
            }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        measurmentChosen = measurementSwitchChoice.titleForSegment(at: measurementSwitchChoice.selectedSegmentIndex)!
        heightWeightDefaults.set(measurementSwitchChoice.selectedSegmentIndex, forKey: "measurementChoiceEntered")
        if measurmentChosen == "Imperial"{
            if firstHeightChosen == ""{
                self.firstHeightPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(firstHeightPicker, didSelectRow: 0, inComponent: 0)
            }
            firstHeightMeasurement = firstHeightChosen
            heightWeightDefaults.set(firstHeightRowChosen, forKey: "firstHeightRowChosen")
            if secondHeightChosen == ""{
                self.secondHeightPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(secondHeightPicker, didSelectRow: 0, inComponent: 0)
            }
            secondHeightMeasurement = secondHeightChosen
            heightWeightDefaults.set(secondHeightRowChosen, forKey: "secondHeightRowChosen")
            if weightChosen == ""{
                self.weightPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(weightPicker, didSelectRow: 0, inComponent: 0)
            }
            weightMeasurement = weightChosen
            heightWeightDefaults.set(weightRowChosen, forKey: "weightRowChosen")
        }
        if measurmentChosen == "Metric"{
            if firstHeightChosenMetric == ""{
                self.metricHeightPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(metricHeightPicker, didSelectRow: 0, inComponent: 0)
            }
            firstHeightMeasurement = firstHeightChosenMetric
            heightWeightDefaults.set(firstHeightRowChosenMetric, forKey: "firstHeightRowChosenMetric")
            if secondHeightChosenMetric == ""{
                self.secondMetricPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(secondMetricPicker, didSelectRow: 0, inComponent: 0)
            }
            secondHeightMeasurement = secondHeightChosenMetric
            heightWeightDefaults.set(secondHeightRowChosenMetric, forKey: "secondHeightRowChosenMetric")
            if weightChosenMetric == ""{
                self.metricWeightPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(metricWeightPicker, didSelectRow: 0, inComponent: 0)
            }
            weightMeasurement = weightChosenMetric
            heightWeightDefaults.set(weightRowChosenMetric, forKey: "weightRowChosenMetric")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        measurmentChosen = measurementSwitchChoice.titleForSegment(at: measurementSwitchChoice.selectedSegmentIndex)!
        heightWeightDefaults.set(measurementSwitchChoice.selectedSegmentIndex, forKey: "measurementChoiceEntered")
        if measurmentChosen == "Imperial"{
            firstHeightMeasurement = firstHeightChosen
            heightWeightDefaults.set(firstHeightRowChosen, forKey: "firstHeightRowChosen")
            secondHeightMeasurement = secondHeightChosen
            heightWeightDefaults.set(secondHeightRowChosen, forKey: "secondHeightRowChosen")
            weightMeasurement = weightChosen
            heightWeightDefaults.set(weightRowChosen, forKey: "weightRowChosen")
        }
        if measurmentChosen == "Metric"{
            firstHeightMeasurement = firstHeightChosenMetric
            heightWeightDefaults.set(firstHeightRowChosenMetric, forKey: "firstHeightRowChosenMetric")
            secondHeightMeasurement = secondHeightChosenMetric
            heightWeightDefaults.set(secondHeightRowChosenMetric, forKey: "secondHeightRowChosenMetric")
            weightMeasurement = weightChosenMetric
            heightWeightDefaults.set(weightRowChosenMetric, forKey: "weightRowChosenMetric")
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            firstHeightChosen = feetFirst[row]
            firstHeightRowChosen = firstHeightPicker.selectedRow(inComponent: 0)
        }
        if pickerView == metricHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            firstHeightChosenMetric = meterFirst[row]
            firstHeightRowChosenMetric = metricHeightPicker.selectedRow(inComponent: 0)

        }
        if pickerView == secondHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            secondHeightChosen = inches[row]
            secondHeightRowChosen = secondHeightPicker.selectedRow(inComponent: 0)
        }
        if pickerView == secondMetricPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            secondHeightChosenMetric = meterExact[row]
            secondHeightRowChosenMetric = secondMetricPicker.selectedRow(inComponent: 0)

        }
        if pickerView == weightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            weightChosen = pounds[row]
            weightRowChosen = weightPicker.selectedRow(inComponent: 0)

        }
        if pickerView == metricWeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            weightChosenMetric = kilograms[row]
            weightRowChosenMetric = metricWeightPicker.selectedRow(inComponent: 0)

        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            return feetFirst[row]
        }
        if pickerView == metricHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            return meterFirst[row]
        }
        if pickerView == secondHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            return inches[row]
        }
        if pickerView == secondMetricPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            return meterExact[row]
        }
        if pickerView == weightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            return pounds[row]
        }
        if pickerView == metricWeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            return kilograms[row]
        }
        return feetFirst[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0 {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor(red: 0.1529, green: 0.6823, blue: 0.3764, alpha: 1.0)
        pickerLabel.text = feetFirst[row]
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 36)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
        }
        if pickerView == metricHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            let pickerLabel = UILabel()
            pickerLabel.textColor = UIColor(red: 0.1529, green: 0.6823, blue: 0.3764, alpha: 1.0)
            pickerLabel.text = meterFirst[row]
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 36)
            pickerLabel.textAlignment = NSTextAlignment.center
            
            return pickerLabel
        }
        if pickerView == secondHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            let pickerLabel = UILabel()
            pickerLabel.textColor = UIColor(red: 0.1529, green: 0.6823, blue: 0.3764, alpha: 1.0)
            pickerLabel.text = inches[row]
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 36)
            pickerLabel.textAlignment = NSTextAlignment.center
            
            return pickerLabel
        }
        if pickerView == secondMetricPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            let pickerLabel = UILabel()
            pickerLabel.textColor = UIColor(red: 0.1529, green: 0.6823, blue: 0.3764, alpha: 1.0)
            pickerLabel.text = meterExact[row]
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 36)
            pickerLabel.textAlignment = NSTextAlignment.center
            
            return pickerLabel
        }
        if pickerView == weightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            let pickerLabel = UILabel()
            pickerLabel.textColor = UIColor(red: 0.1529, green: 0.6823, blue: 0.3764, alpha: 1.0)
            pickerLabel.text = pounds[row]
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 36)
            pickerLabel.textAlignment = NSTextAlignment.center
            
            return pickerLabel
        }
        if pickerView == metricWeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            let pickerLabel = UILabel()
            pickerLabel.textColor = UIColor(red: 0.1529, green: 0.6823, blue: 0.3764, alpha: 1.0)
            pickerLabel.text = kilograms[row]
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 36)
            pickerLabel.textAlignment = NSTextAlignment.center
            
            return pickerLabel
        }

        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor(red: 0.1529, green: 0.6823, blue: 0.3764, alpha: 1.0)
        pickerLabel.text = feetFirst[row]
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 36)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == firstHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            return feetFirst.count
        }
        if pickerView == metricHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            return meterFirst.count
        }
        if pickerView == secondHeightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            return inches.count
        }
        if pickerView == secondMetricPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            return meterExact.count
        }
        if pickerView == weightPicker && measurementSwitchChoice.selectedSegmentIndex == 0{
            return pounds.count
        }
        if pickerView == metricWeightPicker && measurementSwitchChoice.selectedSegmentIndex == 1{
            return kilograms.count
        }
        return 4
    }
}
