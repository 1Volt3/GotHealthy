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
    @IBOutlet weak var profilePhotoChosen: UIImageView!
    @IBOutlet weak var BMIValue: UILabel!
    @IBOutlet weak var BMIStatusValue: UILabel!
    
    var sharedDefaults: UserDefaults! = UserDefaults(suiteName: defaultsSuiteName)
    let defaults = UserDefaults.standard
    var heightValueChosen = ""
    var weightValueChosen = ""
    var inchesCalculated = 0.0
    var metersCalculated = 0.0
    
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
            metersCalculated = Double(heightValueChosen)!
        }
        if measurmentChosen == "Imperial"{
            let dateImperialBorn = String(month) + "/" + String(day) + "/" + String(year)
            birthdateChosen.text = dateImperialBorn
            heightValueChosen = String(firstHeightMeasurement) + "\'" + String(secondHeightMeasurement) + "\""
            weightValueChosen = String(weightMeasurement) + " lbs"
            inchesCalculated = (Double(firstHeightMeasurement)! * 12.0) + Double(secondHeightMeasurement)!
        }
        genderChosen.text = gender
        heightChosen.text = heightValueChosen
        weightChosen.text = weightValueChosen
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
        if measurmentChosen == "Imperial"{
            let bmi: Float = (Float(weightMeasurement)! / Float(inchesCalculated*inchesCalculated)) * 703
            BMIValue.text = "\(bmi)"
            self.changeStatus(bmi)
        }
        if measurmentChosen == "Metric"{
            let bmi: Float = (Float(weightMeasurement)! / Float(metersCalculated*metersCalculated)) * 703
            BMIValue.text = "\(bmi)"
            self.changeStatus(bmi)
        }
    }
    
    fileprivate func changeStatus(_ bmi: Float) {
        if (bmi < 18) {
            BMIStatusValue.text = "Underweight"
            BMIStatusValue.textColor = UIColor.blue
        } else if (bmi >= 18 && bmi < 25) {
            BMIStatusValue.text = "Normal"
            BMIStatusValue.textColor = UIColor.green
        } else if (bmi >= 25 && bmi < 30) {
            BMIStatusValue.text = "Pre-obese"
            BMIStatusValue.textColor = UIColor.purple
        } else {
            BMIStatusValue.text = "Obese"
            BMIStatusValue.textColor = UIColor.red
        }
    }
}
