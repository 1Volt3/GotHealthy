//
//  TabViewController.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/17/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class TabViewController: UIViewController{
    
    @IBOutlet var Buttons: [FaveButton]!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profileTabButton: FaveButton!
    @IBOutlet weak var activityTabButton: FaveButton!
    @IBOutlet weak var exerciseTabButton: FaveButton!
    @IBOutlet weak var nutritionTabButton: FaveButton!
    @IBOutlet weak var settingsTabButton: FaveButton!
    
    var profileViewController: UIViewController!
    var healthViewController: UIViewController!
    var exerciseViewController: UIViewController!
    var nutritionViewController : UIViewController!
    var settingsViewController: UIViewController!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        healthViewController = storyboard.instantiateViewController(withIdentifier: "HealthViewController")
        exerciseViewController = storyboard.instantiateViewController(withIdentifier: "ExerciseViewController")
        nutritionViewController = storyboard.instantiateViewController(withIdentifier: "NutritionViewController")
        settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        viewControllers = [profileViewController, healthViewController, exerciseViewController, nutritionViewController, settingsViewController]
        Buttons[selectedIndex].isSelected = true
        didPressTab(Buttons[selectedIndex])
    }

    @IBAction func didPressTab(_ sender: FaveButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        Buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
}
