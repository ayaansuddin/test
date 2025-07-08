import SwiftUI

@main
struct testApp: App {
    @StateObject var authManager = AuthManager()
    @StateObject var runManager = RunManager() // <-- Add this

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
                .environmentObject(runManager) // <-- Add this
        }
    }
}
