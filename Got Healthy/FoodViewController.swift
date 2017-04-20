//
//  FoodViewController.swift
//  menu
//
//  Created by Aliya Gangji on 4/1/17.
//  Copyright © 2017 Aliya Gangji. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var foodChart: UITableView!
    
    var dayOfWeek = ""
    var timeOfDay = ""
    var currentCell = ""
    var dietRestrictionString = ""
    
    var foodOptions = [String]()
    var sectionHeader = [String]()
    var groups = [[String]]()
    var dietRestrictions = [[String]]()
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! FoodTableViewCell
        
        cell2.headerLabel?.text = sectionHeader[section]
        
        if "Chef's Table" == sectionHeader[section]{
            cell2.foodImage.image = #imageLiteral(resourceName: "chef.png")
        }
        if "Croutons" == sectionHeader[section]{
            cell2.foodImage.image = #imageLiteral(resourceName: "salad.png")
        }
        if "Mangia Mangia" == sectionHeader[section]{
            cell2.foodImage.image = #imageLiteral(resourceName: "pasta.png")
        }
        if "Wildfire Grille" == sectionHeader[section]{
            cell2.foodImage.image = #imageLiteral(resourceName: "grill.png")
        }
        if "Chew St. Deli" == sectionHeader[section]{
            cell2.foodImage.image = #imageLiteral(resourceName: "sandwich.png")
        }
        if "Magellan's" == sectionHeader[section]{
            cell2.foodImage.image = #imageLiteral(resourceName: "tray.png")
        }
        
        return cell2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        currentCell = groups[(indexPath.section)][(indexPath.row)]
        dietRestrictionString =  dietRestrictions[indexPath.section][indexPath.row]

        
        
        performSegue(withIdentifier: "selectItem", sender: self)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
   


  
    
    @IBAction func pressBackButton(_ sender: Any) {
        
        performSegue(withIdentifier: "backButton", sender: self)
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FoodTableViewCell
        
        cell.textLabel?.text = groups[indexPath.section][indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "backButton" {
            if let TimeVC = segue.destination as? TimeViewController {
                TimeVC.dayOfWeek = dayOfWeek 
                TimeVC.timeOfDayString = timeOfDay
            }
        }
        if segue.identifier == "selectItem" {
            if let ItemVC = segue.destination as? ItemViewController {
                ItemVC.foodItem = currentCell
                ItemVC.dayOfWeek = dayOfWeek
                ItemVC.timeOfDay = timeOfDay
                ItemVC.dietRestrictions = dietRestrictionString
            }
        }
       
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL: NSURL = NSURL(string: "http://mathcs.muhlenberg.edu/~ag249083/foodJson9")!
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
                        
                        
                        if let articlesFromJson = json[self.dayOfWeek + self.timeOfDay] as? [String : NSDictionary] {
                            for (key,value) in articlesFromJson {
                                self.sectionHeader.append(String(describing: key))
                                var food = [String]()
                               var temp = [String]()
                                
                                for (key2, value2) in value {
                          
                                    food.append(key2 as! String)
                                    temp.append(String(describing: value2))
                                    
                                    
                                }
                                self.groups.append(food)
                                self.dietRestrictions.append(temp)
                            }
                            self.foodChart.reloadData()
                            
                        }
                            
                        else{
                            print("This did not work")
                        }
                        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
