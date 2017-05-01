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
    var item = [Dining]()
    
    @IBOutlet weak var servingsTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet var servingChangeButton: UIButton!
    
    struct TableItem {
        let title: String
        let creationDate: NSDate
    }
    
    var sections = Dictionary<String, Array<TableItem>>()
    var sortedSections = [String]()
    
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
        self.loadCoreData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func loadCoreData() {
        
        let fetchRequest: NSFetchRequest<Dining> = Dining.fetchRequest()
        do {
            self.item = try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(String(format: "Error %@: %d",#file, #line))
        }
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
            let date:String = "your date in string..."
            
            //if we don't have section for particular date, create new one, otherwise we'll just add item to existing section
            if self.sections.index(forKey: date) == nil {
                //self.sections[date] = [TableItem(title: name, creationDate: date)]
            }
            else {
                //self.sections[date]!.append(TableItem(title: name, creationDate: date))
            }
            
            //we are storing our sections in dictionary, so we need to sort it
            //self.sortedSections = self.sections.keys.array.sorted()
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let userData = Dining(context: context)
            userData.foodName = descriptionValue
            userData.totalCalories = caloriesValue
            //userData.date =
            selectedIndex = 3
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HomePage") as! TabViewController
            self.present(controller, animated: false, completion: { () -> Void in
            })
        }
    }
    
}
