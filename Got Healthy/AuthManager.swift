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
    private static let signInKey = "SIGNIN"

    class var signedIn: Bool {
        return userDefaults.bool(forKey: signInKey)
    }

    class func signIn() {
        userDefaults.set(true, forKey: signInKey)
    }

    class func signOut() {
        userDefaults.set(false, forKey: signInKey)
    }
}
