//
//  ProfileView.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/15/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameChosen: UILabel!
    @IBOutlet weak var ageChosen: UILabel!
    @IBOutlet weak var birthdateChosen: UILabel!
    @IBOutlet weak var genderChosen: UILabel!
    @IBOutlet weak var heightChosen: UILabel!
    @IBOutlet weak var weightChosen: UILabel!
    @IBOutlet weak var measurementChosen: UILabel!
    @IBOutlet weak var profilePhotoChosen: UIImageView!
    var sharedDefaults: UserDefaults! = UserDefaults(suiteName: defaultsSuiteName)
    let defaults = UserDefaults.standard
    var heightValueChosen = ""
    var weightValueChosen = ""
    
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
        calculateBMI()
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
    
    fileprivate func calculateBMI() {
        let height: Float = heightSlider.value
        let weight: Float = weightSlider.value
        let bmi: Float = (weight / (height*height)) * 703
        
        calculatedValue.text = "\(bmi)"
        self.changeStatus(bmi)
    }
    
    fileprivate func changeStatus(_ bmi: Float) {
        if (bmi < 18) {
            statusLabel.text = "underweight"
            statusLabel.textColor = UIColor.blue
        } else if (bmi >= 18 && bmi < 25) {
            statusLabel.text = "normal"
            statusLabel.textColor = UIColor.green
        } else if (bmi >= 25 && bmi < 30) {
            statusLabel.text = "pre-obese"
            statusLabel.textColor = UIColor.purple
        } else {
            statusLabel.text = "obese"
            statusLabel.textColor = UIColor.red
        }
    }
    
}
