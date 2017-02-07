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
        // initialize custom keyboard
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        
        // the view controller will be notified by the keyboard whenever a key is tapped
        //keyboardView.delegate = self
    }
    
}
