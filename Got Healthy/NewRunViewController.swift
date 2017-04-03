//
//  NewRunViewController.swift
//  GotHealthy
//
//  Created by Josh Rosenzweig on 3/04/16.
//  Copyright © 2016 Volt. All rights reserved.
//


//SOMotionDetector - Pedometer tracking
import UIKit
import AVFoundation
import CoreLocation
import CoreData
import CoreMotion
import AudioToolbox
import HealthKit
import MapKit

let DetailSegueName = "RunDetails"

class NewRunViewController: UIViewController{
    //var managedObjectContext: NSManagedObjectContext?
    var run: Run!
    var locationArr = [CLLocation?]()
    var startingLocation: CLLocation?
    var distanceTraveled: Double = 0
    var paceDisplayMinute = 0
    var paceDisplaySecond = 0
    var runMinutes = 0
    var runSeconds = 0
    var runningSeconds = 0
    var walkingSeconds = 0
    var walkMinutes = 0
    var walkSeconds = 0
    var seconds = 0.00
    var distance = 0.00
    var totalSeconds = 0.00
    var downRun = 0
    var downWalk = 0
    var downSeconds = 0.00
    var runFinish = false
    var walkFinish = false
    var location = Int()
    var counter = 0
    var cycleCount = ""
    var cyclesRemaining = 0
    var cyclesComleted = 0
    var totalCycles = 0
    var startTime = TimeInterval()
    var runWalkStatus = false
    var cycleDone = false
    var blurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var walkTimeLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var showMap: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBAction func returnButton(_ sender: AnyObject) {
        runView.isHidden = true
        returnButton.isHidden = true
        blurEffectView.removeFromSuperview()
    }
    
    @IBOutlet weak var runView: MKMapView!
    @IBOutlet weak var cycleCompletedLabel: UILabel!
    @IBOutlet weak var cycleRemainingLabel: UILabel!
    @IBOutlet weak var cycleRemainingNumber: UILabel!
    @IBOutlet weak var cycleCompletedNumber: UILabel!
    
    @IBOutlet weak var cycleProgressView: UIProgressView!
    @IBAction func displayMap(_ sender: AnyObject) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        runView.isHidden = false
        view.bringSubview(toFront: runView)
        returnButton.isHidden = false
        view.bringSubview(toFront: returnButton)
    }
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .fitness
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    lazy var locations: [CLLocation] = []
    lazy var locationsList: [Location] = []
    lazy var timer = Timer()
    lazy var rWRTimer = Timer()
    lazy var vibrateTimer = Timer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        stopButton.isHidden = false
        seconds = 0.0
        distance = 0.0
        locationManager.requestAlwaysAuthorization()
        runView.isHidden = true
        returnButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewRunViewController.eachSecond(_:)), userInfo: nil, repeats: true)
        startLocationUpdates()
        let aSelector : Selector = #selector(NewRunViewController.updateTime)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = Date.timeIntervalSinceReferenceDate
        print("Location is: \(location)")
        if runWalkStatus == true{
            if cycleCount != "Unlimited"{
                cyclesRemaining = Int(cycleCount)!
                totalCycles = cyclesRemaining
                cycleCompletedLabel.isHidden = false
                cycleRemainingLabel.isHidden = false
                cycleRemainingNumber.isHidden = false
                cycleCompletedNumber.isHidden = false
                cycleProgressView.isHidden = false
                cycleRemainingNumber.text = "\(cyclesRemaining)"
                cycleCompletedNumber.text = "\(cyclesComleted)"
                self.cycleProgressView.progressTintColor = UIColor.blue
            }
            if cycleCount == "Unlimited"{
                cycleCompletedLabel.isHidden = true
                cycleRemainingLabel.isHidden = true
                cycleRemainingNumber.isHidden = true
                cycleCompletedNumber.isHidden = true
                cycleProgressView.isHidden = true
            }
            runTimeLabel.isHidden = false
            walkTimeLabel.isHidden = false
            runningSeconds = (runMinutes * 60) + runSeconds
            walkingSeconds = (walkMinutes * 60) + walkSeconds
            downRun = runningSeconds
            downWalk = walkingSeconds
            runFinish = false
            walkFinish = true
            rWRTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewRunViewController.countDown(_:)), userInfo: nil, repeats: true)
            let rWRSelector : Selector = #selector(NewRunViewController.runWalkRunTime)
            rWRTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: rWRSelector, userInfo: nil, repeats: true)
        }
        
        if runWalkStatus == false{
            runTimeLabel.isHidden = true
            walkTimeLabel.isHidden = true
            cycleCompletedLabel.isHidden = true
            cycleRemainingLabel.isHidden = true
            cycleRemainingNumber.isHidden = true
            cycleCompletedNumber.isHidden = true
            cycleProgressView.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func eachSecond(_ timer: Timer) {
        seconds += 1
        totalSeconds = seconds
        distanceLabel.text = "\(String(format: "%.2f", self.distanceTraveled))"
        paceLabel.text = "\(paceDisplayMinute)'\(NSString(format:"%.2d", paceDisplaySecond))\"/mile"
    }
    
    func countDown(_ rWRTimer: Timer) {
        if runFinish != true{
            downRun -= 1
        }
        if walkFinish != true{
            downWalk -= 1
        }
        
    }
    
    func runWalkRunTime(){
        let runMinute = Int(Double(downRun) / 60.0) % 60
        let runSecond = Int(Double(downRun)) % 60
        let runSeconds = String(format: "%02d", runSecond)
        
        let walkMinute = Int(Double(downWalk) / 60.0) % 60
        let walkSecond = Int(Double(downWalk)) % 60
        let walkSeconds = String(format: "%02d", walkSecond)
        
        if runFinish != true{
            walkTimeLabel.text = "Walk: \(walkMinute):\(walkSeconds)"
            let currentTime = Date.timeIntervalSinceReferenceDate
            var elapsedTime: TimeInterval = currentTime - startTime
            
            elapsedTime -= (TimeInterval(runMinute) * 60)
            
            elapsedTime -= (TimeInterval(runSecond))
            
            if downRun < 60{
                runTimeLabel.text = "Run: \(runSecond)"
            }
            if downRun >= 60 && downRun < 3600{
                runTimeLabel.text = "Run: \(runMinute):\(runSeconds)"
            }
            if downRun == 0{
                runFinish = true
                walkFinish = false
                downRun = runningSeconds
                // create a sound ID, in this case its the tweet sound.
                let systemSoundID: SystemSoundID = 1334
                
                // to play sound
                AudioServicesPlaySystemSound (systemSoundID)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
        if walkFinish != true{
            runTimeLabel.text = "Run: \(runMinute):\(runSeconds)"
            let currentTime = Date.timeIntervalSinceReferenceDate
            var elapsedTime: TimeInterval = currentTime - startTime
            
            elapsedTime -= (TimeInterval(walkMinute) * 60)
            
            elapsedTime -= (TimeInterval(walkSecond))
            
            if downWalk < 60{
                walkTimeLabel.text = "Walk: \(walkSecond)"
            }
            if downWalk >= 60 && downWalk < 3600{
                walkTimeLabel.text = "Walk: \(walkMinute):\(walkSeconds)"
            }
            if downWalk == 2{
                if cycleCount != "Unlimited"{
                    if cyclesRemaining == 1{
                        let systemSoundID: SystemSoundID = 1322
                        
                        AudioServicesPlaySystemSound (systemSoundID)
                        cycleDone = true
                    }
                }
            }
            
            if downWalk == 1{
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            if downWalk == 0{
                if cycleCount != "Unlimited"{
                    if cyclesRemaining > 0{
                        cyclesRemaining -= 1
                        cyclesComleted += 1
                        cycleRemainingNumber.text = "\(cyclesRemaining)"
                        cycleCompletedNumber.text = "\(cyclesComleted)"
                        let percent = min(Float(self.cyclesComleted) / Float(self.totalCycles), 1.0)
                        self.cycleProgressView.setProgress(percent, animated: false)
                    }
                }
                cycleChecker()
                if cycleDone == true{
                    walkTimeLabel.text = "Walk: \(walkMinute):\(walkSeconds)"
                    rWRTimer.invalidate()
                    runTimeLabel.isHidden = true
                    walkTimeLabel.isHidden = true
                }
                if cyclesRemaining > 0 || cycleCount == "Unlimited"{
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    // create a sound ID, in this case its the tweet sound.
                    let systemSoundID: SystemSoundID = 1335
                    
                    // to play sound
                    AudioServicesPlaySystemSound (systemSoundID)
                }
                walkFinish = true
                runFinish = false
                downWalk = walkingSeconds
            }
        }
    }
    
    func cycleChecker(){
        if cycleCount != "Unlimited"{
            if cyclesRemaining == 0{
                let systemSoundID: SystemSoundID = 1327
                
                AudioServicesPlaySystemSound (systemSoundID)
                cycleDone = true
            }
        }
    }
    
    func updateTime() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        let hours = UInt8(elapsedTime / 3600)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minutes, seconds and milliseconds as assign it to the UILabel
        if totalSeconds < 60{
            timeLabel.text = "\(seconds)"
        }
        if totalSeconds >= 60 && totalSeconds < 3600{
            timeLabel.text = "\(minutes):\(strSeconds)"
        }
        if totalSeconds >= 3600{
            timeLabel.text = "\(hours):\(strMinutes):\(strSeconds)"
        }
    }
    
    func startLocationUpdates() {
        // Here, the location manager will be lazily instantiated
        locationManager.startUpdatingLocation()
    }
    
    func saveRun() {
        // 2
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let savedRun = NSEntityDescription.insertNewObject(forEntityName: "Run",
                                                           into: managedObjectContext!) as! Run
        savedRun.distance = NSNumber(value: distance)
        savedRun.duration = NSNumber(value: seconds)
        savedRun.timestamp = (Date() as NSDate) as Date
        
        // 2
        var savedLocations = [Location]()
        for location in locations {
            let savedLocation = NSEntityDescription.insertNewObject(forEntityName: "Location",
                                                                    into: managedObjectContext!) as! Location
            savedLocation.timestamp = (location.timestamp as NSDate) as Date
            savedLocation.latitude = NSNumber(value: location.coordinate.latitude)
            savedLocation.longitude = NSNumber(value: location.coordinate.longitude)
            savedLocations.append(savedLocation)
        }
        
        savedRun.locations = NSOrderedSet(array: savedLocations)
        run = savedRun
    }
    
    @IBAction func startPressed(_ sender: AnyObject) {
        
        timeLabel.isHidden = false
        distanceLabel.isHidden = false
        paceLabel.isHidden = false
        stopButton.isHidden = false
        
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewRunViewController.eachSecond(_:)), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewRunViewController.countDown(_:)), userInfo: nil, repeats: true)
        startLocationUpdates()
        
        runView.isHidden = false
    }
    
    @IBAction func stopPressed(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "End Run", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let Save = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            self.saveRun()
            OperationQueue.main.addOperation({ () -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.performSegue(withIdentifier: DetailSegueName, sender: nil)
                })
            })
        })
        let  Delete = UIAlertAction(title: "Delete", style: .destructive) { (action) -> Void in
            OperationQueue.main.addOperation({ () -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExerciseViewController")
                    self.runFinish = true
                    self.walkFinish = true
                    self.downRun = 0
                    self.downWalk = 0
                    self.timer.invalidate()
                    self.rWRTimer.invalidate()
                    self.view.endEditing(true)
                    self.present(viewController, animated: true, completion: nil)
                })
            })
        }
        alertController.addAction(Save)
        alertController.addAction(Delete)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(alertAction: UIAlertAction!)in
            alertController.dismiss(animated: true, completion: nil)}))
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? RunDetailViewController {
            self.runFinish = true
            self.walkFinish = true
            self.downRun = 0
            self.downWalk = 0
            self.timer.invalidate()
            self.rWRTimer.invalidate()
            self.view.endEditing(true)
            detailViewController.run = run
            detailViewController.finalDistance = distanceTraveled
            detailViewController.finalPaceMinute = paceDisplayMinute
            detailViewController.finalPaceSecond = paceDisplaySecond
            detailViewController.finalTotalTime = totalSeconds
        }
    }
}

// MARK: - MKMapViewDelegate
extension NewRunViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer! {
        if !overlay.isKind(of: MKPolyline.self) {
            return nil
        }
        
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3
        return renderer
    }
}

// MARK: - CLLocationManagerDelegate
extension NewRunViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        // Store users initial location - necessary for distance traveled
        if locationArr.count != 1 {
            self.locationArr.append(userLocation)
            self.startingLocation = self.locationArr.first!
        }
        
        for location in locations {
            let howRecent = location.timestamp.timeIntervalSinceNow
            if abs(howRecent) < 10 && location.horizontalAccuracy < 20 {
                //update distance
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                    
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)
                    
                    let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
                    runView.setRegion(region, animated: true)
                    
                    runView.add(MKPolyline(coordinates: &coords, count: coords.count))
                }
                self.distanceTraveled = distance * 0.000621371
                let paceDisplayInMPH = userLocation.speed * 2.23694
                if paceDisplayInMPH > 0 && paceDisplayInMPH <= 100{
                    self.paceDisplayMinute = Int(60/paceDisplayInMPH)
                    self.paceDisplaySecond = Int(((60/paceDisplayInMPH) - Double(paceDisplayMinute)) * 60)
                }
                //save location
                self.locations.append(location)
            }
        }
    }
}
