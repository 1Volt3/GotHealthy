//
//  ProfileView.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/15/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.statusBarStyle = .default
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
            calculatedCentimeters = (Double(firstHeightMeasurement)! * 100.0) + Double(secondHeightMeasurement)!
            calculatedGrams = Double(weightMeasurement)!
        }
        if measurmentChosen == "Imperial"{
            let dateImperialBorn = String(month) + "/" + String(day) + "/" + String(year)
            birthdateChosen.text = dateImperialBorn
            heightValueChosen = String(firstHeightMeasurement) + "\'" + String(secondHeightMeasurement) + "\""
            weightValueChosen = String(weightMeasurement) + " lbs"
            let inchesCalculated = (Double(firstHeightMeasurement)! * 12.0) + Double(secondHeightMeasurement)!
        }
        genderChosen.text = gender
        heightChosen.text = heightValueChosen
        weightChosen.text = weightValueChosen
        measurementChosen.text = measurmentChosen
        if let imgData = defaults.object(forKey: "imageChosen") as? NSData
        {
            if let image = UIImage(data: imgData as Data)
            {
                //set image in UIImageView imgSignature
                profilePhotoChosen.image = image
            }
        }
        profilePhotoChosen.layer.cornerRadius = 10.0
        profilePhotoChosen.layer.borderWidth = 3
        profilePhotoChosen.layer.borderColor = UIColor.black.cgColor
        profilePhotoChosen.clipsToBounds = true
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
    
}
