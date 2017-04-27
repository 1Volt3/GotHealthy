//
//  DiningOverView.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 4/26/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit
import CoreData

class DiningOverView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var dining : Dining? = nil
    
    var item = [Dining]()
    
    @IBOutlet var tableView: UITableView!
    
    func loadCoreData() {
        
        let fetchRequest: NSFetchRequest<Dining> = Dining.fetchRequest()
        if self.dining != nil {
            fetchRequest.predicate = NSPredicate(format: "Dining = %@", self.dining!)
        }
        do {
            item = try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(String(format: "Error %@: %d",#file, #line))
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiningChoices", for: indexPath)
        
        cell.textLabel!.text = item[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert: UIAlertController =
                UIAlertController(title: "Warning!", message: "Remove data?", preferredStyle:  UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction =
                UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    context.delete(self.item[indexPath.row])
                    do {
                        try context.save()
                    } catch {
                        print(String(format: "Error %@: %d",#file, #line))
                    }
                    
                    self.loadCoreData()
                    tableView.deleteRows(at: [indexPath], with: .fade)
                })
            let cancelAction: UIAlertAction =
                UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{
                    (action: UIAlertAction!) -> Void in
                    self.tableView.reloadData()
                })
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
