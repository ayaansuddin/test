import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var runManager: RunManager

    @State private var enableNotifications: Bool = true
    @State private var appVersion: String = "1.0.0"
    @AppStorage("isDarkModeEnabled") private var useDarkMode: Bool = false
    
    @State private var showingLogRunSheet = false

    var body: some View {
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
                            .padding(.bottom, 20)

                        Button(action: {
                            showingLogRunSheet = true
                        }) {
                            Label("Log New Run", systemImage: "plus.circle.fill")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        .sheet(isPresented: $showingLogRunSheet) {
                            LogRunView()
                        }

                        List {
                            Section(header: Text("Past Runs")) {
                                if runManager.runs.isEmpty {
                                    Text("No runs logged yet. Log your first run!")
                                        .foregroundColor(.gray)
                                } else {
                                    ForEach(runManager.runs) { (run: Run) in // Explicit type here to help compiler
                                        HStack {
                                            Image(systemName: "figure.run")
                                            VStack(alignment: .leading) {
                                                Text("Run on \(run.date.formatted(date: .abbreviated, time: .omitted))")
                                                    .font(.headline)
                                                Text("Distance: \(run.distance.formatted(.number.precision(.fractionLength(1)))) km")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                                Text("Time: \(run.formattedTime) • Pace: \(run.formattedPace)/km")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                                Text("Location: \(run.locationName)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 5)
                                    }
                                    .onDelete(perform: runManager.deleteRun)
                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                        .padding(.top, 10)
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
            SignInView()
        }
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthManager())
            .environmentObject(RunManager())
    }
}
