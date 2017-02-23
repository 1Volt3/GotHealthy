//
//  NameEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

var firstName = ""
var lastName = ""

class NameEntry: UIViewController {
    
    @IBOutlet weak var firstNameEntry: FloatingTextField!
    @IBOutlet weak var lastNameEntry: FloatingTextField!
    @IBOutlet weak var nextArrow: UIButton!
    let nameDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        firstNameEntry.keyboardType = UIKeyboardType.asciiCapable
        if let firstNameStoredBefore = nameDefaults.string(forKey: "firstNameEntered") {
            firstNameEntry.text = firstNameStoredBefore
        }
        if let lastNameStoredBefore = nameDefaults.string(forKey: "lastNameEntered") {
            lastNameEntry.text = lastNameStoredBefore
        }
        if firstNameEntry.text != "" && lastNameEntry.text != ""{
            nextArrow.isHidden = false
        }
        else{
            nextArrow.isHidden = true
        }
    }

    func textFieldDidChange(_ textField: UITextField) {
        if firstNameEntry.text != "" && lastNameEntry.text != ""{
            nextArrow.isHidden = false
    }
        else{
            nextArrow.isHidden = true
        }
    }
    @IBAction func nextArrowPressed(_ sender: Any) {
        firstName = firstNameEntry.text!
        nameDefaults.set(firstNameEntry.text!, forKey: "firstNameEntered")
        lastName = lastNameEntry.text!
        nameDefaults.set(lastNameEntry.text!, forKey: "lastNameEntered")
    }
}
