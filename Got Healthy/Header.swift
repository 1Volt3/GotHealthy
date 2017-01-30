//
//  Header.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 1/26/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import Foundation

// MARK: - User Defaults

let StepCountKey = "TodayViewStepCount"
let FloorCountKey = "TodayViewFloorCount"
let DistanceKey = "TodayViewDistance"
let UserGoalKey = "TodayViewUserGoal"
let UnitTypeKey = "TodayViewUnitType"
let UnitDisplayKey = "TodayViewUnitDisplay"
let defaultsSuiteName = "group.SachinPatel.Steps.TodayExtensionSharingDefaults"

// MARK: - Units

enum UnitSystem: Int {
    case imperial = 0
    case metric = 1
}

enum UnitDisplay: Int {
    case short = 0
    case long = 1
}

// Unit Conversions
let mileInMeters = 1609.344

let UnitSystemImperialWord = "mile"
let UnitSystemMetricWord = "kilometer"

let UnitSystemImperialWordShort = "mi"
let UnitSystemMetricWordShort = "km"
