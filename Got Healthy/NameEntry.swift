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

    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -100, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -100, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moveTextField(textField, moveDistance: -100, up: false)
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        //self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        lastNameEntry.frame = lastNameEntry.frame.offsetBy(dx: 0, dy: movement)
        nextArrow.frame = nextArrow.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
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
