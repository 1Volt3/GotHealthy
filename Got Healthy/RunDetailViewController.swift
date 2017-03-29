//
//  RunDetailViewController.swift
//  GotHealthy
//
//  Created by Josh Rosenzweig on 3/04/16.
//  Copyright © 2016 Volt. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class RunDetailViewController: UIViewController {
    var run: Run!
    var finalDistance = 0.00
    var finalPaceMinute = 0
    var finalPaceSecond = 0
    var finalTotalTime = 0.00
    var averagePaceMinute = 0
    var averagePaceSecond = 0
    lazy var allFinalLocations: [CLLocationCoordinate2D] = []
    var timeString = ""
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        UserDefaults.standard.setValue(finalDistance, forKey: "Final Distance")
    }
    
    func configureView() {
        distanceLabel.text = "Distance: \(String(format: "%.2f", self.finalDistance))"
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = DateFormatter.Style.full
        let convertedDate = dateFormatter.string(from: currentDate)
        dateLabel.text = "\(convertedDate)"
        
        timeLabel.text = "\(timeString)"
        
        if finalTotalTime != 0 && finalDistance != 0 {
        averagePaceMinute = (Int(finalTotalTime / finalDistance))/60
        let x:Double = ((finalTotalTime / finalDistance)/60)
        let numberOfPlaces:Double = 2.0
        let powerOfTen:Double = pow(10.0, numberOfPlaces)
        let fractionPace:Double = round((x.truncatingRemainder(dividingBy: 1.0)) * powerOfTen) / powerOfTen
        averagePaceSecond = Int(fractionPace * 60)
        }
        else{
            averagePaceMinute = 0
            averagePaceSecond = 0
        }
        print("Average is: \(averagePaceSecond)")
        paceLabel.text = "Pace: " + "\(averagePaceMinute)'\(NSString(format:"%.2d", averagePaceSecond))\"/mile"
        
        loadMap()
    }
    
    func timeConverter(_ totalSeconds: Double) -> String{
        //calculate the minutes from total seconds.
        let minutes = UInt8((totalSeconds / 60.0).truncatingRemainder(dividingBy: 60))
        
        //calculate the seconds from total seconds.
        let seconds = UInt8(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        let hours = UInt8(totalSeconds / 3600)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minutes, seconds and milliseconds as assign it to the UILabel
        if totalSeconds < 60{
            timeString = "Time: \(seconds)"
            return timeString
        }
        if totalSeconds >= 60 && totalSeconds < 3600{
            timeString = "Time: \(minutes):\(strSeconds)"
            return timeString
        }
        if totalSeconds >= 3600{
            timeString = "Time: \(hours):\(strMinutes):\(strSeconds)"
            return timeString
        }
        return timeString
    }
    
    func mapRegion() -> MKCoordinateRegion {
        let initialLoc = run.locations.firstObject as! Location
        
        var minLat = initialLoc.latitude.doubleValue
        var minLng = initialLoc.longitude.doubleValue
        var maxLat = minLat
        var maxLng = minLng
        
        let locations = run.locations.array as! [Location]
        
        for location in locations {
            minLat = min(minLat, location.latitude.doubleValue)
            minLng = min(minLng, location.longitude.doubleValue)
            maxLat = max(maxLat, location.latitude.doubleValue)
            maxLng = max(maxLng, location.longitude.doubleValue)
        }
        
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2,
                longitude: (minLng + maxLng)/2),
            span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.1,
                longitudeDelta: (maxLng - minLng)*1.1))
    }
    
    func mapView(_ mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if !overlay.isKind(of: MulticolorPolylineSegment.self) {
            return nil
        }
        
        let polyline = overlay as! MulticolorPolylineSegment
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = polyline.color
        renderer.lineWidth = 3
        return renderer
    }
    
    func polyline() -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        
        let locations = run.locations.array as! [Location]
        for location in locations {
            coords.append(CLLocationCoordinate2D(latitude: location.latitude.doubleValue,
                longitude: location.longitude.doubleValue))
        }
        
        return MKPolyline(coordinates: &coords, count: run.locations.count)
    }
    
    func loadMap() {
        if run.locations.count > 0 {
            mapView.isHidden = false
            
            // Set the map bounds
            mapView.region = mapRegion()
            
            // Make the line(s!) on the map
            let colorSegments = MulticolorPolylineSegment.colorSegments(forLocations: run.locations.array as! [Location])
            mapView.addOverlays(colorSegments)
        } else {
            // No locations were found!
            mapView.isHidden = true
            
            let locationAlert = UIAlertController(title: "Location Error", message: "Sorry, this run has no locations saved, no map is available.", preferredStyle: UIAlertControllerStyle.alert)
            locationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            }))
            present(locationAlert, animated: true, completion:nil)
        }
    }
    
}

// MARK: - MKMapViewDelegate
//extension DetailViewController: MKMapViewDelegate {
//}
