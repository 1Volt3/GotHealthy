//
//  ViewController.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 1/25/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameChosen: UILabel!
    @IBOutlet weak var ageChosen: UILabel!
    @IBOutlet weak var birthdateChosen: UILabel!
    @IBOutlet weak var genderChosen: UILabel!
    @IBOutlet weak var heightChosen: UILabel!
    @IBOutlet weak var weightChosen: UILabel!
    @IBOutlet weak var measurementChosen: UILabel!
    var sharedDefaults: UserDefaults! = UserDefaults(suiteName: defaultsSuiteName)
    let defaults = UserDefaults.standard
    var heightValueChosen = ""
    var weightValueChosen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fullName = firstName + " " + lastName
        nameChosen.text = fullName
        let now = NSDate()
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.year, from: birthDate, to: now as Date, options: [])
        let age = ageComponents.year!
        ageChosen.text = String(age)
        let dateCalendar = Calendar.current
        let year = dateCalendar.component(.year, from: birthDate)
        let month = dateCalendar.component(.month, from: birthDate)
        let day = dateCalendar.component(.day, from: birthDate)
        if measurmentChosen == "Metric"{
            let dateMetricBorn = String(day) + "/" + String(month) + "/" + String(year)
            birthdateChosen.text = dateMetricBorn
            heightValueChosen = String(firstHeightMeasurement) + "." + String(secondHeightMeasurement)
            weightValueChosen = String(weightMeasurement) + " kgs"
        }
        if measurmentChosen == "Imperial"{
            let dateImperialBorn = String(month) + "/" + String(day) + "/" + String(year)
            birthdateChosen.text = dateImperialBorn
            heightValueChosen = String(firstHeightMeasurement) + "\'" + String(secondHeightMeasurement) + "\""
            weightValueChosen = String(weightMeasurement) + " lbs"
            
        }
        genderChosen.text = gender
        heightChosen.text = heightValueChosen
        weightChosen.text = weightValueChosen
        measurementChosen.text = measurmentChosen
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        let refreshAlert = UIAlertController(title: "Memory Warning",
                                             message: "All data cannot be saved.", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok",
                                             style: .default, handler: { (action: UIAlertAction!) in print("Memory Warning")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

    // Pedometer
    var stepCount: Int
    var distance: Double
    var pedometer: CMPedometer
    
    // MARK: - Initializers
    
    init() {
        stepCount = 0
        distance = 0.0
        pedometer = CMPedometer()
        sharedDefaults = UserDefaults(suiteName: defaultsSuiteName)!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        stepCount = 0
        distance = 0.0
        pedometer = CMPedometer()
        sharedDefaults = UserDefaults(suiteName: defaultsSuiteName)!
        super.init(coder: aDecoder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Read from user defaults to show while updating data
        stepCount = sharedDefaults.integer(forKey: StepCountKey)
        distance = sharedDefaults.double(forKey: DistanceKey)
        
        // Update interface before
        updateInterface()
        updatePedometer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TodayViewController.updateInterface), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sharedDefaults.set(stepCount, forKey: StepCountKey)
        sharedDefaults.set(distance, forKey: DistanceKey)
        sharedDefaults.synchronize()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    var unitSystemType: UnitSystem? {
        get {
            let raw = sharedDefaults.integer(forKey: UnitTypeKey)
            return UnitSystem(rawValue: raw)
        }
        set {
            sharedDefaults.set(newValue!.rawValue, forKey: UnitTypeKey)
            updateInterface()
        }
    }
    
    var unitDisplayType: UnitDisplay? {
        get {
            let raw = sharedDefaults.integer(forKey: UnitDisplayKey)
            return UnitDisplay(rawValue: raw)
        }
        set {
            sharedDefaults.set(newValue!.rawValue, forKey: UnitDisplayKey)
            updateInterface()
        }
    }
    
    var unitSystemWord: String {
        switch (unitSystemType!) {
        case .imperial:
            switch (unitDisplayType!) {
            case .short: return UnitSystemImperialWordShort
            case .long: return UnitSystemImperialWord
            }
        case .metric:
            switch (unitDisplayType!) {
            case .short: return UnitSystemMetricWordShort
            case .long: return UnitSystemMetricWord
            }
        }
    }
    
    // MARK: - Widget
    func updatePedometer () {
        // Ensure device has motion coprocessor
        if CMPedometer.isStepCountingAvailable() {
            
            // Get data from midnight to now
            pedometer.queryPedometerData(from: Date.midnight, to: Date(), withHandler: {
                data, error in
                
                if data != nil {
                    // Store data
                    self.stepCount = data!.numberOfSteps.intValue
                    if CMPedometer.isDistanceAvailable() {
                        self.distance = data!.distance!.doubleValue
                    }
                    self.updateInterface()
                }
                
                // Update as user moves
                self.pedometer.startUpdates(from: Date(), withHandler: {
                    data, error in
                    
                    if data != nil {
                        // Add to existing counts
                        self.stepCount += data!.numberOfSteps.intValue
                        if CMPedometer.isDistanceAvailable() {
                            self.distance += data!.distance!.doubleValue
                        }
                        self.updateInterface()
                    }
                })
            })
        }
    }
    
    func updateInterface () {
        DispatchQueue.main.async(execute: {
            // Update step count label, format nicely
            if self.stepCount < 10_000 {
                self.stepCountLabel.text = "\(self.stepCount)"
            } else {
                let number = NSNumber(value: self.stepCount as Int)
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.groupingSeparator = ","
                self.stepCountLabel.text = formatter.string(for: number)
            }
        });
        
        // Update distance label if available
        if CMPedometer.isDistanceAvailable() {
            // Update mile count label
            var convertedDistance = self.distance
            switch self.unitSystemType! {
            case .imperial:
               convertedDistance /= mileInMeters
            case .metric:
                convertedDistance /= 1000
            }
            
            let distanceExtension = (self.unitDisplayType == .long && self.distance != 1) ? "s" : ""
            DispatchQueue.main.async(execute: {
                self.distanceLabel.isHidden = false
                self.distanceLabel.text = NSString(format: "%.2f %@%@", convertedDistance, self.unitSystemWord, distanceExtension) as String
            });
        } else {
            DispatchQueue.main.async(execute: {
                self.distanceLabel.isHidden = true
            });
        }
        
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}

