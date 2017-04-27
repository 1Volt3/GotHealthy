//
//  ServingChoice.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 4/26/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

var descriptionValue = ""
var caloriesValue = ""
var dayValue = ""

class ServingChoice: UIViewController{
 
    @IBOutlet weak var servingsTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ServingChoice.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        servingsTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if descriptionValue != "" && caloriesValue != ""{
            descriptionLabel.text = descriptionValue
            caloriesLabel.text = caloriesValue
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
