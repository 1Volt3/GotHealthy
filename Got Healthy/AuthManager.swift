//
//  AuthManager.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 1/28/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import Foundation

final class AuthManager {
    private static var userDefaults = UserDefaults.standard
    private static let informationEnetered = "INFOENTERED"

    class var signedIn: Bool {
        return userDefaults.bool(forKey: informationEnetered)
    }

    class func signIn() {
        userDefaults.set(true, forKey: informationEnetered)
    }

    class func signOut() {
        userDefaults.set(false, forKey: informationEnetered)
    }
}
