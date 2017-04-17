//
//  Constants.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 4/15/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import Foundation

public enum Constants {
  public static func bundle() -> String {
    return "GotHealthy"
  }

  public enum WatchContext: Int {
    case current, date
    public func key() -> String {
      switch self {
      case .current:
        return "WATCH_CURRENT"
      case .date:
        return "WATCH_DATE"
      }
    }
  }

  public enum UnitsOfMeasure: Int {
    case imperial, metric

    func nameForUnitOfMeasure() -> String {
      switch self {
      case .imperial:
        return NSLocalizedString("Imperial", comment: "")
      case .metric:
        return NSLocalizedString("Metric", comment: "")
      }
    }

    func suffixForUnitOfMeasure() -> String {
      switch self {
      case .imperial:
        return "I"
      case .metric:
        return "M"
      }
    }
  }

  public enum General: Int {
    case unitOfMeasure, onboardingShown

    public func key() -> String {
      switch self {
      case .unitOfMeasure:
        return "UNIT_OF_MEASURE"
      case .onboardingShown:
        return "ONBOARDING_SHOWN"
      }
    }
  }

  public enum Health: Int {
    case on
    public func key() -> String {
      switch self {
      case .on:
        return "HEALTH_ON"
      }
    }
  }

  public enum Notification: Int {
    case on, from, to, interval
    public func key() -> String {
      switch self {
      case .on:
        return "NOTIFICATION_ON"
      case .from:
        return "NOTIFICATION_FROM"
      case .to:
        return "NOTIFICATION_TO"
      case .interval:
        return "NOTIFICATION_INTERVAL"
      }
    }
  }
}
