//
//  NameEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class NameEntry: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 1/255, blue: 1/255, alpha: 1.0)
        
        let firstNameInput = FloatingLabelText(frame: CGRect(x: 90, y: 60, width: 300, height: 45))
        firstNameInput.placeholder = "First"
        firstNameInput.title = "Your First Name"
        firstNameInput.tintColor = overcastBlueColor
        firstNameInput.textColor = darkGreyColor
        firstNameInput.lineColor = lightGreyColor
        firstNameInput.selectedTitleColor = overcastBlueColor
        firstNameInput.selectedLineColor = overcastBlueColor
        self.view.addSubview(firstNameInput)
        
        let lastNameInput = FloatingLabelText(frame: CGRect(x: 90, y: 120, width: 300, height: 45))
        lastNameInput.placeholder = "Last"
        lastNameInput.title = "Your Last Name"
        lastNameInput.tintColor = overcastBlueColor
        lastNameInput.textColor = darkGreyColor
        lastNameInput.lineColor = lightGreyColor
        lastNameInput.selectedTitleColor = overcastBlueColor
        lastNameInput.selectedLineColor = overcastBlueColor
        self.view.addSubview(firstNameInput)
    }

}
