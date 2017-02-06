//
//  FloatingLabelTextIcon.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/6/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

open class FloatingLabelTextIcon: FloatingLabelText {

    /// A UILabel value that identifies the label used to display the icon
    open var iconLabel:UILabel!
    
    /// A UIFont value that determines the font that the icon is using
    @IBInspectable
    open var iconFont:UIFont? {
        didSet {
            self.iconLabel?.font = iconFont
        }
    }
    
    /// A String value that determines the text used when displaying the icon
    @IBInspectable
    open var iconText:String? {
        didSet {
            self.iconLabel?.text = iconText
        }
    }
    
    /// A UIColor value that determines the color of the icon in the normal state
    @IBInspectable
    open var iconColor:UIColor = UIColor.gray {
        didSet {
            self.updateIconLabelColor()
        }
    }
    
    /// A UIColor value that determines the color of the icon when the control is selected
    @IBInspectable
    open var selectedIconColor:UIColor = UIColor.gray {
        didSet {
            self.updateIconLabelColor()
        }
    }
    
    /// A float value that determines the width of the icon
    @IBInspectable open var iconWidth:CGFloat = 20 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the left margin of the icon. Use this value to position the icon more precisely horizontally.
    @IBInspectable open var iconMarginLeft:CGFloat = 4 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the bottom margin of the icon. Use this value to position the icon more precisely vertically.
    @IBInspectable
    open var iconMarginBottom:CGFloat = 4 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the rotation in degrees of the icon. Use this value to rotate the icon in either direction.
    @IBInspectable
    open var iconRotationDegrees:Double = 0 {
        didSet {
            self.iconLabel.transform = CGAffineTransform(rotationAngle: CGFloat(iconRotationDegrees * M_PI / 180.0))
        }
    }
    
    // MARK: Initializers
    
    /**
    Initializes the control
    */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.createIconLabel()
    }
    
    /**
     Intialzies the control by deserializing it
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createIconLabel()
    }
    
    // MARK: Creating the icon label
    
    /// Creates the icon label
    fileprivate func createIconLabel() {
        let iconLabel = UILabel()
        iconLabel.backgroundColor = UIColor.clear
        iconLabel.textAlignment = .center
        iconLabel.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.iconLabel = iconLabel
        self.addSubview(iconLabel)
        
        self.updateIconLabelColor()
    }
    
    // MARK: Handling the icon color
    
    /// Update the colors for the control. Override to customize colors.
    override open func updateColors() {
        super.updateColors()
        self.updateIconLabelColor()
    }
    
    fileprivate func updateIconLabelColor() {
        if self.hasErrorMessage {
            self.iconLabel?.textColor = self.errorColor
        } else {
            self.iconLabel?.textColor = self.editingOrSelected ? self.selectedIconColor : self.iconColor
        }
    }
    
    // MARK: Custom layout overrides
    
    /**
    Calculate the bounds for the textfield component of the control. Override to create a custom size textbox in the control.
    */
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
        } else {
            rect.origin.x -= CGFloat(iconWidth + iconMarginLeft)
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginLeft)
        return rect
    }

    /**
     Calculate the rectangle for the textfield when it is being edited
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginLeft)
        return rect
    }

    /**
     Calculates the bounds for the placeholder component of the control. Override to create a custom size textbox in the control.
     */
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginLeft)
        return rect
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
    
    fileprivate func updateFrame() {
        let textHeight = self.textHeight()
        let textWidth:CGFloat = self.bounds.size.width
        if isLTRLanguage {
            self.iconLabel.frame = CGRect(x: 0, y: self.bounds.size.height - textHeight - iconMarginBottom, width: iconWidth, height: textHeight)
        } else {
            self.iconLabel.frame = CGRect(x: textWidth - iconWidth , y: self.bounds.size.height - textHeight - iconMarginBottom, width: iconWidth, height: textHeight)
        }
    }
}
