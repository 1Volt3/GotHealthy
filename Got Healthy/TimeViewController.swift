//
//  TimeViewController.swift
//  menu
//
//  Created by Aliya Gangji on 3/15/17.
//  Copyright © 2017 Aliya Gangji. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dayOfWeek: String?
    
    var timeOfDayString = ""
    
    var timeOfDay = [String]()
    
    var currentCell = ""

        
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

            return timeOfDay.count
        
        
        
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")

        cell.textLabel?.text = timeOfDay[indexPath.row]
        
        return cell

    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let arrayVal = (indexPath?[1])! as Int
        
        currentCell = timeOfDay[arrayVal]
        
        performSegue(withIdentifier: "showFood", sender: self)
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showFood" {
            if let FoodVC = segue.destination as? FoodViewController {
                FoodVC.dayOfWeek = dayOfWeek!
                FoodVC.timeOfDay = currentCell
            }
        }
        else{
            print("This did not work")
        }
    }
 
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if  "Saturday"  == dayOfWeek || "Sunday" == dayOfWeek {
            timeOfDay.append("Lunch")
            timeOfDay.append("Dinner")
         }
        else{
            timeOfDay.append("Breakfast")
            timeOfDay.append("Lunch")
            timeOfDay.append("Dinner")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
