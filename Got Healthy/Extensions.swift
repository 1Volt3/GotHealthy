//
//  Extensions.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 1/28/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    static var midnight: Date {
    let calendar = Calendar.autoupdatingCurrent
        let components: NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day]
        return calendar.date(from: (calendar as NSCalendar).components(components, from: Date()))!
    }
}
