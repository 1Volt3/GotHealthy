//
//  Gender.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/8/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

var gender = ""

class Gender: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nextButton.isHidden = true
    }
    
    @IBAction func maleButtonPressed(_ sender: Any) {
        maleButton.setBackgroundImage(UIImage(named: "ButtonBoxGreen.png"), for: UIControlState.normal)
        femaleButton.setBackgroundImage(UIImage(named: "GrayBoxButton.png"), for: UIControlState.normal)
        nextButton.isHidden = false

    }
    
    @IBAction func femaleButtonPressed(_ sender: Any) {
        femaleButton.setBackgroundImage(UIImage(named: "ButtonBoxGreen.png"), for: UIControlState.normal)
        maleButton.setBackgroundImage(UIImage(named: "GrayBoxButton.png"), for: UIControlState.normal)
        nextButton.isHidden = false
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        if maleButton.backgroundImage(for: UIControlState.normal) == UIImage(named: "ButtonBoxGreen.png"){
            gender = "Male"
        }
        if femaleButton.backgroundImage(for: UIControlState.normal) == UIImage(named: "ButtonBoxGreen.png"){
            gender = "Female"
        }
    }
}
