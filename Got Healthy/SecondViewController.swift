//
//  SecondViewController.swift
//  Got Healthy
//
//  Created by Aliya Gangji on 2/24/17.
//  Copyright © 2017 Aliya Gangji. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var foodEntry: UITextField!
    @IBOutlet weak var calorieEntry: UITextField!
    @IBOutlet weak var toolbarCalorieCount: UIBarButtonItem!
   
    @IBAction func addFood(_ sender: Any) {
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        
        var items: [String]
     
        
        if let tempItems = itemsObject as? [String] {
            
             items = tempItems
        
             items.append(foodEntry.text! + ", " + calorieEntry.text! + " calories")
        }
        else{
             items = [foodEntry.text! + ", " + calorieEntry.text! + " calories"]
        }
        
        UserDefaults.standard.set(items, forKey: "items")
       
        foodEntry.text = ""
        calorieEntry.text = ""
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
