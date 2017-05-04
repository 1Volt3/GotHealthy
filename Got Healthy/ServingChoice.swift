//
//  ServingChoice.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 4/26/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit
import CoreData

var descriptionValue = ""
var caloriesValue = ""
var dayValue = ""

class ServingChoice: UIViewController{
 
    public var dining : Dining?
    var managedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var servingsTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet var servingChangeButton: UIButton!
    
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
    
    @IBAction func servingChangeButtonPressed(_ sender: Any) {
        if Double(servingsTextField.text!) == nil{
            let servingAlert = UIAlertController(
                title: "Serving Size",
                message: "Sorry, only valid serving size!",
                preferredStyle: .alert)
            let okServing = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            servingAlert.addAction(okServing)
            present(
                servingAlert,
                animated: true,
                completion: nil)
        }
        else{
            guard managedObjectContext != nil else { return }
            if dining == nil {
                // Create Dining
                let newDining = Dining(context: managedObjectContext!)
                
                // Configure Dining
                newDining.date = dayValue
                
                // Set Dining
                dining = newDining
            }
            
            if let dining = dining {
                // Configure Dining
                let totalCalories = Int(caloriesValue)! * Int(servingsTextField.text!)!
                dining.foodName = descriptionValue
                dining.totalCalories = String(totalCalories)
                dining.servings = servingsTextField.text!
            }
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let userData = Dining(context: context)
            let totalCalories = Int(caloriesValue)! * Int(servingsTextField.text!)!
            userData.foodName = descriptionValue
            userData.totalCalories = String(totalCalories)
            userData.servings = servingsTextField.text!
            userData.date = dayValue
            selectedIndex = 3
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HomePage") as! TabViewController
            self.present(controller, animated: false, completion: { () -> Void in
            })
        }
    }
    
}
