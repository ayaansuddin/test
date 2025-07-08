import Foundation
import SwiftUI

class RunManager: ObservableObject {
    // @Published makes the 'runs' array observable by SwiftUI views.
    // @AppStorage stores the runs array persistently in UserDefaults.
    // We use JSONEncoder/Decoder to convert the array to/from Data for storage.
    @AppStorage("runsData") private var runsData: Data = Data()

    @Published var runs: [Run] = [] {
        didSet {
            // Whenever 'runs' array changes, encode it to Data and save to UserDefaults.
            if let encoded = try? JSONEncoder().encode(runs) {
                runsData = encoded
            }
        }
    }

    init() {
        // When RunManager is initialized, load runs from UserDefaults.
        if let decoded = try? JSONDecoder().decode([Run].self, from: runsData) {
            self.runs = decoded
        }
    }

    func addRun(_ run: Run) {
        runs.insert(run, at: 0) // Add new runs to the top of the list
    }
    
    // Optional: Delete a run
    func deleteRun(at offsets: IndexSet) {
        runs.remove(atOffsets: offsets)
    }
}
