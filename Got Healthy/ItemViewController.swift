//
//  ItemViewController.swift
//  menu
//
//  Created by Aliya Gangji on 4/15/17.
//  Copyright © 2017 Aliya Gangji. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var specialLabel: UILabel!

    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!

    @IBOutlet weak var servingSizeLabel: UILabel!
    var foodItem = ""
    var dayOfWeek = ""
    var timeOfDay = ""
    var descript = ""
    var calories = ""
    var servingSize = ""
    var servingSizeInGrams = ""
    var dietRestrictions = ""
    var dietRestructionsString = ""

    override func viewWillAppear(_ animated: Bool) {
        if dietRestrictions.range(of: "Mindful = Yes;") != nil {          dietRestructionsString = "Mindful Item"
        }
        if dietRestrictions.range(of: "Vegan = Yes;") != nil {
            if dietRestructionsString.isEmpty {
                 dietRestructionsString = "Vegan Item"
            }
            else{
                dietRestructionsString = dietRestructionsString +  ", Vegan Item"
            }
        }
        if dietRestrictions.range(of: "Vegetarian = Yes;") != nil {
            if dietRestructionsString.isEmpty {
                dietRestructionsString = "Vegetarian Item"
            }
            else{
                dietRestructionsString = dietRestructionsString +  ", Vegetarian Item"
            }
        }
        print(dietRestrictions)
        foodLabel.text = foodItem
        let requestURL: NSURL = NSURL(string: "http://mathcs.muhlenberg.edu/~ag249083/foodJson10")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
            }
            
            if (statusCode == 200) {
                
                do{
                
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary{
                        
                        print(self.foodItem)
                     if let articlesFromJson = json[self.foodItem] as? [String : String] {
                        self.descriptionLabel.text = articlesFromJson["Description"]!
                        print(articlesFromJson["Description"]!)
                        self.servingSize = articlesFromJson["servingSize"]! + "(" + articlesFromJson["servingSizeInGrams"]! + ")"
                        self.servingSizeLabel.text = self.servingSize
                        self.caloriesLabel.text = articlesFromJson["calories"]!
                        if let special = articlesFromJson["Special"] {
                        
                            
                            if self.dietRestructionsString.isEmpty {
                               self.specialLabel.text = special
                            }
                            else{
                                self.specialLabel.text = self.dietRestructionsString +  ", " + special
                            }
                            
                            
                            
                        }
                        else{
                            self.specialLabel.text = "N/A"
                        }


                        
                        }
                            
                       else{
                        self.descriptionLabel.text = "Description not available for this item"
                        self.servingSizeLabel.text = "N/A"
                        self.caloriesLabel.text = "N/A"
                        self.specialLabel.text = "N/A"


                        }
                        
                }
                    else{
                        print("FAIL")
                    }
                    
                    
                    
                }
                
            }
        }
        
        task.resume()

       
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func pressBackButton(_ sender: Any) {
       
            performSegue(withIdentifier: "backButton", sender: self)
 
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "backButton" {
            if let FoodVC = segue.destination as? FoodViewController {
                FoodVC.dayOfWeek = dayOfWeek
                FoodVC.timeOfDay = timeOfDay
            }
        }

        
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
