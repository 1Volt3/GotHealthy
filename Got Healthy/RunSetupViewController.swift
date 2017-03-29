//
//  RunSetupViewController.swift
//  GotHealthy
//
//  Created by Josh Rosenzweig on 3/29/17.
//  Copyright © 2016 Volt. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class RunSetupViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var GPSSignalText: UILabel!
    @IBOutlet weak var runPickerView: UIPickerView!
    @IBOutlet weak var walkPickerView: UIPickerView!
    @IBOutlet weak var locationControl: UISegmentedControl!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var cycleAmountButton: UIButton!
    @IBOutlet weak var cycleCountLabel: UILabel!
    @IBOutlet weak var walkTimeLabel: UILabel!
    @IBOutlet weak var correctCycle: UIButton!
    @IBOutlet weak var cancelCycle: UIButton!
    @IBOutlet weak var cyclePickerView: UIPickerView!
    @IBOutlet weak var runWalkRunSwitch: UISwitch!
    
    var locationArr = [CLLocation?]()
    let locationManager = CLLocationManager()
    var current: CLLocation!
    var outdoor = Int()
    var switchState = Bool()
    let switchKey = "switchState"
    var GPSStrength: String = ""
    var runWalkRunState = false
    var runMinute = 0
    var runSecond = 0
    var walkMinute = 0
    var walkSecond = 0
    var cycleChosen = ""
    var blurEffectView: UIVisualEffectView!
    let pickerData = [
        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
        "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"],
        ["00", "15", "20", "30", "40", "45"]
    ]
    
    let cycleData = ["Unlimited", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
        "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]

    
    let totalPages = 5
    
    let sampleBGColors: Array<UIColor> = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.magenta, UIColor.orange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        startLocationUpdates()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        GPSSignalText.text = GPSStrength
        let font = UIFont.systemFont(ofSize: 20)
        locationControl.setTitleTextAttributes([NSFontAttributeName: font],
            for: UIControlState())
        runTimeLabel.text = "Run Time"
        walkTimeLabel.text = "Walk Time"
        runPickerView.dataSource = self
        runPickerView.delegate = self
        walkPickerView.dataSource = self
        walkPickerView.delegate = self
        cyclePickerView.dataSource = self
        cyclePickerView.delegate = self
        runWalkRunSwitch.isOn =  UserDefaults.standard.bool(forKey: "switchState")
        cyclePickerView.isHidden = true
        correctCycle.isHidden = true
        cancelCycle.isHidden = true
        if runWalkRunSwitch.isOn{
            runPickerView.isHidden = false
            walkPickerView.isHidden = false
            runTimeLabel.isHidden = false
            walkTimeLabel.isHidden = false
            cycleAmountButton.isHidden = false
            cycleCountLabel.isHidden = false
            runWalkRunState = true
        }
        else{
            runPickerView.isHidden = true
            walkPickerView.isHidden = true
            runTimeLabel.isHidden = true
            walkTimeLabel.isHidden = true
            cycleAmountButton.isHidden = true
            cycleCountLabel.isHidden = true
            runWalkRunState = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let runMinsLabel: UILabel = UILabel(frame: CGRect(x: -30 + (runPickerView.frame.size.width / 2), y: runPickerView.frame.size.height / 2 - 15, width: 75, height: 30))
        runMinsLabel.text = "min"
        runMinsLabel.textColor = UIColor.white
        runPickerView.addSubview(runMinsLabel)
        let runSecsLabel: UILabel = UILabel(frame: CGRect(x: 54 + (runPickerView.frame.size.width / 2), y: runPickerView.frame.size.height / 2 - 15, width: 75, height: 30))
        runSecsLabel.text = "sec"
        runSecsLabel.textColor = UIColor.white
        runPickerView.addSubview(runSecsLabel)
        self.view!.addSubview(runPickerView)
        
        let walkMinsLabel: UILabel = UILabel(frame: CGRect(x: -30 + (walkPickerView.frame.size.width / 2), y: walkPickerView.frame.size.height / 2 - 15, width: 75, height: 30))
        walkMinsLabel.text = "min"
        walkMinsLabel.textColor = UIColor.white
        walkPickerView.addSubview(walkMinsLabel)
        let walkSecsLabel: UILabel = UILabel(frame: CGRect(x: 54 + (walkPickerView.frame.size.width / 2), y: walkPickerView.frame.size.height / 2 - 15, width: 75, height: 30))
        walkSecsLabel.text = "sec"
        walkSecsLabel.textColor = UIColor.white
        walkPickerView.addSubview(walkSecsLabel)
        self.view!.addSubview(walkPickerView)
    }

    @IBAction func runWalkRunSwitchPressed(_ sender: AnyObject) {
        UserDefaults.standard.set(runWalkRunSwitch.isOn, forKey: "switchState")
        if runWalkRunSwitch.isOn == true{
            runPickerView.isHidden = false
            walkPickerView.isHidden = false
            runTimeLabel.isHidden = false
            walkTimeLabel.isHidden = false
            cycleAmountButton.isHidden = false
            cycleCountLabel.isHidden = false
            runWalkRunState = true
        }
        if runWalkRunSwitch.isOn == false{
            runPickerView.isHidden = true
            walkPickerView.isHidden = true
            runTimeLabel.isHidden = true
            walkTimeLabel.isHidden = true
            cycleAmountButton.isHidden = true
            cycleCountLabel.isHidden = true
            runWalkRunState = false
        }
    }
    
    @IBAction func cycleAmountPressed(_ sender: AnyObject) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        cyclePickerView.isHidden = false
        view.bringSubview(toFront: cyclePickerView)
        correctCycle.isHidden = false
        view.bringSubview(toFront: correctCycle)
        cancelCycle.isHidden = false
        view.bringSubview(toFront: cancelCycle)
    }
    
    @IBAction func correctCyclePressed(_ sender: AnyObject) {
        cyclePickerView.isHidden = true
        correctCycle.isHidden = true
        cancelCycle.isHidden = true
        blurEffectView.removeFromSuperview()
        cycleCountLabel.text = cycleChosen
        if cyclePickerView.selectedRow(inComponent: 0) == 0 {
            cycleCountLabel.text = "Unlimited"
        }
    }
    
    @IBAction func cancelCyclePressed(_ sender: AnyObject) {
        cyclePickerView.isHidden = true
        correctCycle.isHidden = true
        cancelCycle.isHidden = true
        blurEffectView.removeFromSuperview()
    }
    
    @IBAction func beginButtonPressed(_ sender: AnyObject) {
        if runMinute == 0 && runSecond == 0 {
            let runAlert = UIAlertController(title: "Runtime Error", message: "Run Minutes and Run Seconds for Run Walk Run are set to zero. There needs to be at least 15 seconds.", preferredStyle: UIAlertControllerStyle.alert)
            runAlert.addAction(UIAlertAction(title: "Change Runtime", style: .default, handler: { (action: UIAlertAction) in
            }))
            present(runAlert, animated: true, completion:nil)
        }
        if walkMinute == 0 && walkSecond == 0 {
            let alert = UIAlertController(title: "Walktime Error", message: "Walk Minutes and Walk Seconds for Run Walk Run are set to zero. There needs to be at least 15 seconds.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Change Walktime", style: .default, handler: { (action: UIAlertAction) in
            }))
            present(alert, animated: true, completion:nil)
        }
    }
    
    func startLocationUpdates() {
        // Here, the location manager will be lazily instantiated
        locationManager.startUpdatingLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: NewRunViewController.self) {
            if let newRunViewController = segue.destination as? NewRunViewController {
             newRunViewController.runWalkStatus = runWalkRunState
                if runWalkRunSwitch.isOn{
                    if runMinute == 0 && runSecond == 0 {
                        let runAlert = UIAlertController(title: "Runtime Error", message: "Run Minutes and Run Seconds for Run Walk Run are set to zero. There needs to be at least 15 seconds.", preferredStyle: UIAlertControllerStyle.alert)
                        runAlert.addAction(UIAlertAction(title: "Change Runtime", style: .default, handler: { (action: UIAlertAction) in
                        }))
                        present(runAlert, animated: true, completion:nil)
                    }
                    if walkMinute == 0 && walkSecond == 0 {
                        let alert = UIAlertController(title: "Walktime Error", message: "Walk Minutes and Walk Seconds for Run Walk Run are set to zero. There needs to be at least 15 seconds.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Change Walktime", style: .default, handler: { (action: UIAlertAction) in
                        }))
                        present(alert, animated: true, completion:nil)
                    }

             newRunViewController.runMinutes = runMinute
             newRunViewController.runSeconds = runSecond
             newRunViewController.walkMinutes = walkMinute
             newRunViewController.walkSeconds = walkSecond
             newRunViewController.location = outdoor
             newRunViewController.cycleCount = cycleCountLabel.text!
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        // Store users initial location - necessary for distance traveled
        if locationArr.count != 1 {
            self.locationArr.append(userLocation)
        }
        
        for location in locations {
            if location.horizontalAccuracy < 0 {
                //update distance
                if (location.horizontalAccuracy < 0)
                {
                    GPSSignalText.text = "No Signal"
                    print("Checking")
                }
                else if (location.horizontalAccuracy > 163)
                {
                    GPSSignalText.text = "Poor Signal"
                }
                else if (location.horizontalAccuracy > 48)
                {
                    GPSSignalText.text = "Average Signal"
                }
                else
                {
                    GPSSignalText.text = "Full Signal"
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == cyclePickerView{
            return 1
        }
        return pickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cyclePickerView{
            cycleChosen = cycleData[row]
        }
        switch component{
        case 0:
            if pickerView == runPickerView {
            self.runMinute = Int(pickerData[component][row])!
            }
            if pickerView == walkPickerView {
            self.walkMinute = Int(pickerData[component][row])!
            }
        case 1:
            if pickerView == runPickerView {
            self.runSecond = Int(pickerData[component][row])!
            }
            if pickerView == walkPickerView {
            self.walkSecond = Int(pickerData[component][row])!
            }
        default:
            print("No components available")
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cyclePickerView{
            return cycleData[row]
        }
            return pickerData[component][row]
    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        
        if pickerView == cyclePickerView{
            pickerLabel.textColor = UIColor.white
            pickerLabel.text = cycleData[row]
            pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 26)
            pickerLabel.textAlignment = NSTextAlignment.center
            return pickerLabel
        }
        
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = pickerData[component][row]
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 18) 
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cyclePickerView{
            print("Cycle Data 3")
            return cycleData.count
        }
        return pickerData[component].count
    }


}
