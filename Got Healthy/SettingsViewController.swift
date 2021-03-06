//
//  SettingsViewController.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/20/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UIAlertViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var notificationSettingSwitch: UISwitch!
    @IBOutlet weak var notificationFromLabel: UILabel!
    @IBOutlet weak var notificationToLabel: UILabel!
    @IBOutlet weak var notificationTimeLabel: UILabel!
    
    let userDefaults = UserDefaults.groupUserDefaults()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = NSLocalizedString("settings title", comment: "")
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //updateUI()
    }
    
    @IBAction func reminderSwitch(_ sender: Any) {
        userDefaults.set((sender as AnyObject).isOn, forKey: Constants.Notification.on.key())
        userDefaults.synchronize()
        self.tableView.reloadData()
        //updateNotificationPreferences()
    }
    
    /*func updateUI() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var suffix = ""
        if let unit = Constants.UnitsOfMeasure(rawValue: userDefaults.integer(forKey: Constants.General.unitOfMeasure.key())) {
            measurementLabel.text = unit.nameForUnitOfMeasure()
            suffix = unit.suffixForUnitOfMeasure()
        }
        _ = uomLabels.map({$0.text = suffix})
        notificationSettingSwitch.isOn = userDefaults.bool(forKey: Constants.Notification.on.key())
        notificationFromLabel.text = "\(userDefaults.integer(forKey: Constants.Notification.from.key())):00"
        notificationToLabel.text = "\(userDefaults.integer(forKey: Constants.Notification.to.key())):00"
        notificationTimeLabel.text = "\(userDefaults.integer(forKey: Constants.Notification.interval.key())) " +  NSLocalizedString("hours", comment: "")
    }
    
    func updateNotificationPreferences() {
        if (notificationSettingSwitch.isOn) {
            NotificationHelper.unscheduleNotifications()
            NotificationHelper.askPermission()
        } else {
            NotificationHelper.unscheduleNotifications()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var actionSheet: AHKActionSheet?
        if ((indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 0) {
            actionSheet = AHKActionSheet(title: NSLocalizedString("unit of measure title", comment: ""))
            actionSheet?.addButton(withTitle: Constants.UnitsOfMeasure.liters.nameForUnitOfMeasure(), type: .default) { _ in
                self.userDefaults.set(Constants.UnitsOfMeasure.liters.rawValue, forKey: Constants.General.unitOfMeasure.key())
                self.userDefaults.synchronize()
                self.updateUI()
            }
            actionSheet?.addButton(withTitle: Constants.UnitsOfMeasure.ounces.nameForUnitOfMeasure(), type: .default) { _ in
                self.userDefaults.set(Constants.UnitsOfMeasure.ounces.rawValue, forKey: Constants.General.unitOfMeasure.key())
                self.userDefaults.synchronize()
                self.updateUI()
            }
        }
        if ((indexPath as NSIndexPath).section == 2 && (indexPath as NSIndexPath).row == 1) {
            actionSheet = AHKActionSheet(title: NSLocalizedString("from:", comment: ""))
            for index in 5...22 {
                actionSheet?.addButton(withTitle: "\(index):00", type: .default) { _ in
                    self.updateNotificationSetting(Constants.Notification.from.key(), value: index)
                }
            }
        }
        if ((indexPath as NSIndexPath).section == 2 && (indexPath as NSIndexPath).row == 2) {
            actionSheet = AHKActionSheet(title: NSLocalizedString("to:", comment: ""))
            let upper = self.userDefaults.integer(forKey: Constants.Notification.from.key()) + 1
            for index in upper...24 {
                actionSheet?.addButton(withTitle: "\(index):00", type: .default) { _ in
                    self.updateNotificationSetting(Constants.Notification.to.key(), value: index)
                }
            }
        }
        if ((indexPath as NSIndexPath).section == 2 && (indexPath as NSIndexPath).row == 3) {
            actionSheet = AHKActionSheet(title: NSLocalizedString("every:", comment: ""))
            for index in 1...8 {
                let hour = index > 1 ? NSLocalizedString("hours", comment: "") : NSLocalizedString("hour", comment: "")
                actionSheet?.addButton(withTitle: "\(index) \(hour)", type: .default) { _ in
                    self.updateNotificationSetting(Constants.Notification.interval.key(), value: index)
                }
            }
        }
        if let actionSheet = actionSheet {
            actionSheet.show()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return 3
        } else if (section == 2) {
            if UserDefaults.groupUserDefaults().bool(forKey: Constants.Notification.on.key()) {
                return 4
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func storeText(_ textField: UITextField, toKey key: String) {
        guard let text = textField.text else {
            return
        }
        let number = numberFormatter.number(from: text) as? Double
        userDefaults.set(number ?? 0.0, forKey: key)
        userDefaults.synchronize()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return Globals.numericTextField(textField, shouldChangeCharactersInRange: range, replacementString: string)
    }*/
    
}
