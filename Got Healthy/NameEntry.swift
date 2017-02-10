//
//  NameEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/1/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class NameEntry: UIViewController {
    
    @IBOutlet weak var firstNameEntry: FloatingTextField!
    @IBOutlet weak var lastNameEntry: FloatingTextField!
    @IBOutlet weak var nextArrow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextArrow.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        if firstNameEntry.text != "" && lastNameEntry.text != ""{
            nextArrow.isHidden = false
    }
    }

}
