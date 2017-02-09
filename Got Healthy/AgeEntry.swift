//
//  AgeEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class AgeEntry: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dateOfBirthPicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.dateOfBirthPicker.maximumDate = Date()

    }
    
}
