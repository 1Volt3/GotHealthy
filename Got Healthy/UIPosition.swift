//
//  UIPosition.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 2/9/17.
//  Copyright © 2017 Volt. All rights reserved.
//

// MARK: - UITextField extension

import UIKit

extension UITextField {
    /// Moves the caret to the correct position by removing the trailing whitespace
    func fixCaretPosition() {
        let beginning = self.beginningOfDocument
        self.selectedTextRange = self.textRange(from: beginning, to: beginning)
        let end = self.endOfDocument
        self.selectedTextRange = self.textRange(from: end, to: end)
    }
}
