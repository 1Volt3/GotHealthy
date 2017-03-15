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

class NameEntry: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameEntry: FloatingTextField!
    @IBOutlet weak var lastNameEntry: FloatingTextField!
    @IBOutlet weak var nextArrow: UIButton!
    let nameDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.statusBarStyle = .lightContent
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NameEntry.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if firstNameEntry.text != "" && lastNameEntry.text != ""{
            nextArrow.isHidden = false
        }
        else{
            nextArrow.isHidden = true
        }
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        if firstNameEntry.text != "" && lastNameEntry.text != ""{
            nextArrow.isHidden = false
        }
        else{
            nextArrow.isHidden = true
        }
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if firstNameEntry.text != "" && lastNameEntry.text != ""{
            nextArrow.isHidden = false
    }
        else{
            nextArrow.isHidden = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ-\' ")
        if firstNameEntry.text?.rangeOfCharacter(from: characterset.inverted) != nil {
            let firstNameAlert = UIAlertController(
                title: "First Name",
                message: "Sorry, only letters for your first name!",
                preferredStyle: .alert)
            let okFirstName = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            firstNameAlert.addAction(okFirstName)
            present(
                firstNameAlert,
                animated: true,
                completion: nil)
        }
        
        if lastNameEntry.text?.rangeOfCharacter(from: characterset.inverted) != nil {
            let lastNameAlert = UIAlertController(
                title: "Last Name",
                message: "Sorry, only letters for your last name!",
                preferredStyle: .alert)
            let okLastName = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            lastNameAlert.addAction(okLastName)
            present(
                lastNameAlert,
                animated: true,
                completion: nil)
        }
        
        firstName = firstNameEntry.text!
        nameDefaults.set(firstNameEntry.text!, forKey: "firstNameEntered")
        lastName = lastNameEntry.text!
        nameDefaults.set(lastNameEntry.text!, forKey: "lastNameEntered")
    }
}
