//
//  photoEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/6/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class PhotoEntry: UIViewController {
    
    @IBOutlet weak var profilePhotoEntry: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profilePhotoEntry.layer.cornerRadius = profilePhotoEntry.frame.size.width / 2
        profilePhotoEntry.layer.borderWidth = 3
        profilePhotoEntry.layer.borderColor = UIColor.white.cgColor
        profilePhotoEntry.clipsToBounds = true
    }
    
}
