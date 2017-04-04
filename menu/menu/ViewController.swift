//
//  ViewController.swift
//  menu
//
//  Created by Aliya Gangji on 3/15/17.
//  Copyright © 2017 Aliya Gangji. All rights reserved.
//

import UIKit



class ViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var currentCell = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellContent.count
        
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = cellContent[indexPath.row]
        
        return cell
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        
        if segue.identifier == "pickDayOfWeek" {
            if let timeVC = segue.destination as? TimeViewController {
                
               
                timeVC.dayOfWeek = currentCell
            }
        }
        else{
            print("This did not work")
        }
    }
    

        
        //performSegue(withIdentifier: "pickDayOfWeek", sender: currentCell)
        
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
               
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let arrayVal = (indexPath?[1])! as Int
        
        currentCell = cellContent[arrayVal]
        
        performSegue(withIdentifier: "pickDayOfWeek", sender: self)
        
        
      
    }
    

    
    

}

