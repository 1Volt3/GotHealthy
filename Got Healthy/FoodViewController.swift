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
    
    var foodOptions = [String]()
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodOptions.count
        
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = foodOptions[indexPath.row]
        
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(dayOfWeek)
        
        
        let requestURL: NSURL = NSURL(string: "http://mathcs.muhlenberg.edu/~ag249083/foodJson4")!
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
                        
                        
                        if let articlesFromJson = json[self.dayOfWeek] as? [String : NSDictionary] {
                            for (key,_) in articlesFromJson {
                                self.foodOptions.append(String(describing: key))
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
