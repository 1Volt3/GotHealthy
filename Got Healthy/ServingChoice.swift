//
//  ServingChoice.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 4/26/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class ServingChoice: UIViewController{
 
    @IBOutlet weak var servingsTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ServingChoice.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        servingsTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
