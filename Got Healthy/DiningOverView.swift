//
//  DiningOverView.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 4/26/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit
import CoreData

class DiningOverView: UITableView {
    
    struct TableItem {
        let title: String
        let creationDate: NSDate
    }
    
    var sections = Dictionary<String, Array<TableItem>>()
    var sortedSections = [String]()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[sortedSections[section]]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let tableSection = sections[sortedSections[indexPath.section]]
        let tableItem = tableSection![indexPath.row]
        
        //cell.titleLabel?.text = tableItem.title
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedSections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
