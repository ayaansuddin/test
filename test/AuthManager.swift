//
//  AuthManager.swift
//  test (Your app's name)
//
//  Created by Your Name on Today's Date.
//

import Foundation
import SwiftUI

class AuthManager: ObservableObject {
    // @Published makes this property observable by SwiftUI views.
    // @AppStorage persists the value in UserDefaults.
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false {
        didSet {
            // This block executes whenever isLoggedIn changes.
            // Useful for debugging or triggering other actions if needed.
            print("Login status changed to: \(isLoggedIn)")
        }
    }

    // Simulate a login action
    func login() {
        // In a real app, you'd perform network requests, validate credentials, etc.
        // For now, we just set isLoggedIn to true.
        isLoggedIn = true
    }

    // Simulate a logout action
    func logout() {
        // In a real app, you might clear user data, tokens, etc.
        isLoggedIn = false
    }
}
