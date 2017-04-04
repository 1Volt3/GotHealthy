//
//  HomeViewController.swift
//  GotHealthy
//
//  Created by Josh Rosenzweig on 3/29/17.
//  Copyright © 2016 Volt. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion
import QuartzCore

class HomeViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext?
    var sharedDefaults: UserDefaults! = UserDefaults(suiteName: defaultsSuiteName)
    let defaults = UserDefaults.standard
    var distanceAdd = 0.00
    var totalDistance = 0.00
    let inset: CGFloat = 15.0

    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    

    @IBAction func newRunButtonPressed(_ sender: AnyObject) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "RunSetupViewController") as! RunSetupViewController
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        //addWidget()
        totalDistance =  UserDefaults.standard.double(forKey: "Total Miles")
        if (defaults.object(forKey: "Final Distance") as? Double) != nil {
        distanceAdd = (defaults.object(forKey: "Final Distance") as? Double)!
        }
        if distanceAdd > 0 {
            if totalDistance <= 100.00{
            totalDistance += Double(String(format: "%.2f", distanceAdd))!
            defaults.set(totalDistance, forKey: "Total Miles")
            UserDefaults.standard.setValue(0.00, forKey: "Final Distance")
            }
            else{
            totalDistance += distanceAdd
            defaults.set(totalDistance, forKey: "Total Miles")
            UserDefaults.standard.setValue(0.00, forKey: "Final Distance")
            }
        }
        totalDistanceLabel.text = "\(defaults.double(forKey: "Total Miles"))"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Set user defaults
        if userGoal == 0 {
            userGoal = 10_000
        }
        
        // Progress view appearance
        progressView.layer.cornerRadius = 8.0
        progressView.layer.masksToBounds = true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Defines intervals for progress bar color
    let StepCountIntervalLow = Float(0)...Float(0.4)
    let StepCountIntervalMed = Float(0.4)...Float(0.8)
    
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
    var userGoal: Float {
        get {
            return sharedDefaults.float(forKey: UserGoalKey)
        }
        set {
            sharedDefaults.set(newValue, forKey: UserGoalKey)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
        
        if segue.identifier == "RunSetup"{
            let vc = segue.destination as UIViewController
            vc.navigationItem.title = "Run"
            navigationItem.title = "Home"
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
        
        // Update progress indicator
        let percent = min(Float(self.stepCount) / Float(self.userGoal), 1.0)
        self.progressView.setProgress(percent, animated: false)
        switch percent {
        case StepCountIntervalLow:
            self.progressView.progressTintColor = UIColor.red
        case StepCountIntervalMed:
            self.progressView.progressTintColor = UIColor.yellow
        default:
            self.progressView.progressTintColor = UIColor.green
        }
    }
    
}
