//
//  AgeEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

var birthDate = Date()

class AgeEntry: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var nextArrow: UIButton!
    let ageDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.statusBarStyle = .lightContent
        dateOfBirthPicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.dateOfBirthPicker.maximumDate = Date()
        dateOfBirthPicker.addTarget(self, action: #selector(pickerDidChange(_:)), for: .valueChanged)
        if let birthDateStoredBefore = ageDefaults.object(forKey: "birthDateSelected"){
            dateOfBirthPicker.date = birthDateStoredBefore as! Date
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Date().timeIntervalSince(dateOfBirthPicker.date) > 126144000 {
            nextArrow.isHidden = false
        }
        else{
            nextArrow.isHidden = true
        }
    }
    
    func pickerDidChange(_ datePicker: UIDatePicker) {
        if Date().timeIntervalSince(dateOfBirthPicker.date) >  126144000 {
            nextArrow.isHidden = false
        }
        else{
            nextArrow.isHidden = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        birthDate = dateOfBirthPicker.date
        ageDefaults.set(dateOfBirthPicker.date, forKey: "birthDateSelected")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        birthDate = dateOfBirthPicker.date
        ageDefaults.set(dateOfBirthPicker.date, forKey: "birthDateSelected")
    }
}
