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
    
    let genderDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.statusBarStyle = .lightContent
        nextButton.isHidden = true
        if genderDefaults.object(forKey: "genderSelected") != nil{
            if genderDefaults.string(forKey: "genderSelected") != nil {
                if genderDefaults.string(forKey: "genderSelected") == "Male"{
            nextButton.isHidden = false
            maleButton.setBackgroundImage(UIImage(named: "ButtonBoxGreen.png"), for: UIControlState.normal)
            femaleButton.setBackgroundImage(UIImage(named: "GrayBoxButton.png"), for: UIControlState.normal)
                }
                if genderDefaults.string(forKey: "genderSelected") == "Female"{
                    nextButton.isHidden = false
                    femaleButton.setBackgroundImage(UIImage(named: "ButtonBoxGreen.png"), for: UIControlState.normal)
                    maleButton.setBackgroundImage(UIImage(named: "GrayBoxButton.png"), for: UIControlState.normal)
            }
        }
        }
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
            genderDefaults.set(gender, forKey: "genderSelected")
        }
        if femaleButton.backgroundImage(for: UIControlState.normal) == UIImage(named: "ButtonBoxGreen.png"){
            gender = "Female"
            genderDefaults.set(gender, forKey: "genderSelected")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if maleButton.backgroundImage(for: UIControlState.normal) == UIImage(named: "ButtonBoxGreen.png"){
            gender = "Male"
            genderDefaults.set(gender, forKey: "genderSelected")
        }
        if femaleButton.backgroundImage(for: UIControlState.normal) == UIImage(named: "ButtonBoxGreen.png"){
            gender = "Female"
            genderDefaults.set(gender, forKey: "genderSelected")
        }
        _ = navigationController?.popViewController(animated: true)
    }
}
