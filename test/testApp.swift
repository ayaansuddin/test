//
//  testApp.swift
//  test
//
//  Created by Ayaan Uddin on 7/7/25.
//

import SwiftUI

@main
struct testApp: App {
    // Create an instance of AuthManager and hold it as a StateObject.
    // StateObject keeps the object alive for the lifetime of the app.
    @StateObject var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Inject the authManager into the environment,
                // making it accessible to ContentView and its subviews.
                .environmentObject(authManager)
        }
    }
}
