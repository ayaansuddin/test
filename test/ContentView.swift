import SwiftUI

struct ContentView: View {
    // Access the shared AuthManager from the environment
    @EnvironmentObject var authManager: AuthManager

    @State private var enableNotifications: Bool = true
    @State private var appVersion: String = "1.0.0"

    // Removed @AppStorage from useDarkMode as it's now global
    @AppStorage("isDarkModeEnabled") private var useDarkMode: Bool = false

    var body: some View { //this is not chatgpt
        // Conditional view based on login status
        if authManager.isLoggedIn {
            TabView {
                NavigationView {
                    VStack {
                        Spacer()
                        Text("Welcome to RunSafe!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

                NavigationView {
                    VStack {
                        Text("Your Runs Log")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .navigationTitle("Runs")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Runs", systemImage: "figure.run")
                }

                NavigationView {
                    VStack {
                        Text("Your Goals & Progress")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .navigationTitle("Goals")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Goals", systemImage: "target")
                }

                NavigationView {
                    VStack {
                        Text("Community Chat")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .navigationTitle("Chat")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }

                NavigationView {
                    VStack {
                        Text("Your Profile")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                
                NavigationView {
                    VStack {
                        Text("Thrift Store")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .navigationTitle("Thrift Store")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Store", systemImage: "cart")
                }

                NavigationView {
                    Form {
                        Section(header: Text("General")) {
                            Toggle(isOn: $enableNotifications) {
                                Text("Notifications")
                            }
                            
                            Toggle(isOn: $useDarkMode) {
                                Text("Dark Mode")
                            }

                            NavigationLink(destination: AccountSettingsView()) {
                                Label("Account", systemImage: "person.crop.circle")
                            }
                        }

                        Section(header: Text("About")) {
                            HStack {
                                Text("Version")
                                Spacer()
                                Text(appVersion)
                                    .foregroundColor(.gray)
                            }
                            
                            Button(action: {
                                print("Privacy Policy tapped")
                            }) {
                                Text("Privacy Policy")
                            }
                            
                            Button(action: {
                                print("Terms of Service tapped")
                            }) {
                                Text("Terms of Service")
                            }
                        }
                        
                        Section {
                            Button(role: .destructive) {
                                // Call the logout method from AuthManager
                                authManager.logout()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Log Out")
                                    Spacer()
                                }
                            }
                        }
                    }
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            }
            .preferredColorScheme(useDarkMode ? .dark : .light)
            .accentColor(.blue)
        } else {
            // Show the SignInView if not logged in
            SignInView()
        }
    }
}

// MARK: - Example Sub-Settings View (unchanged)
struct AccountSettingsView: View {
    var body: some View {
        Form {
            Section(header: Text("Account Details")) {
                Text("User ID: 12345")
                Text("Email: user@example.com")
            }
            Section {
                Button("Change Password") {
                    print("Change password tapped")
                }
            }
        }
        .navigationTitle("Account")
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            // Important: Provide an AuthManager for the preview too
            .environmentObject(AuthManager())
    }
}
