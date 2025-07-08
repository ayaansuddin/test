import Foundation

// Identifiable is needed for ForEach in Lists
struct Run: Identifiable, Codable {
    var id = UUID() // Unique ID for each run
    var date: Date
    var distance: Double // in kilometers or miles
    var time: TimeInterval // in seconds
    var pace: TimeInterval // in seconds per unit of distance (e.g., seconds per km/mile)
    var locationName: String // e.g., "Central Park", "Local Neighborhood"

    // Helper to format time as HH:MM:SS
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: time) ?? "00:00:00"
    }

    // Helper to format pace as MM:SS / unit
    var formattedPace: String {
        let minutes = Int(pace) / 60
        let seconds = Int(pace) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
