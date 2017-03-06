//
//  Keyboard.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/3/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: class
{
    func keyWasTapped(character: String)
    func backspace()
}

class Keyboard: UIView {
    
    // This variable will be set as the view controller so that
    // the keyboard can send messages to the view controller.
    weak var delegate: KeyboardDelegate?
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "Keyboard" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    // MARK:- Button actions from .xib file
    @IBAction func keyTapped(sender: UIButton) {
        // When a button is tapped, send that information to the delegate
        self.delegate?.keyWasTapped(character: sender.titleLabel!.text!)
    }
    
    @IBAction func backspace(sender: UIButton) {
        self.delegate?.backspace()
    }
}
