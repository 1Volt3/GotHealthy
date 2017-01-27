//
//  UIColor+AppColors.swift
//  Steps
//
//  Created by Sachin Patel on 9/21/14.
//  Copyright (c) 2014 Sachin Patel. All rights reserved.
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
