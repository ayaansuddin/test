import SwiftUI
import MapKit // Needed for potential map integration

struct LogRunView: View {
    @EnvironmentObject var runManager: RunManager // To add the new run
    @Environment(\.dismiss) var dismiss // To close the sheet

    @State private var runDate: Date = Date()
    @State private var distance: Double = 0.0
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var locationName: String = "Manual Entry"

    @State private var showingMapPicker: Bool = false

    private var totalTimeInSeconds: TimeInterval {
        TimeInterval(hours * 3600 + minutes * 60 + seconds)
    }

    private var calculatedPace: TimeInterval {
        if distance > 0 && totalTimeInSeconds > 0 {
            return totalTimeInSeconds / distance
        }
        return 0
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Run Details")) {
                    DatePicker("Date", selection: $runDate, displayedComponents: .date)

                    VStack(alignment: .leading) {
                        Text("Distance (km)")
                        Slider(value: $distance, in: 0...100, step: 0.1) {
                            Text("Distance")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("100")
                        }
                        Text(String(format: "%.1f km", distance))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    VStack(alignment: .leading) {
                        Text("Time")
                        HStack {
                            Picker("Hours", selection: $hours) {
                                ForEach(0..<24) { i in Text("\(i)h").tag(i) }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80)
                            .clipped()

                            Picker("Minutes", selection: $minutes) {
                                ForEach(0..<60) { i in Text("\(i)m").tag(i) }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80)
                            .clipped()

                            Picker("Seconds", selection: $seconds) {
                                ForEach(0..<60) { i in Text("\(i)s").tag(i) }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80)
                            .clipped()
                        }
                        .padding(.vertical, -10)

                        Text("Total Time: \(totalTimeInSeconds.formattedTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Pace")
                        Spacer()
                        Text("\(calculatedPace.formattedPace) /km")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Location")
                        Spacer()
                        Text(locationName)
                            .foregroundColor(.gray)
                        Button(action: {
                            // showingMapPicker = true
                            print("Open map for location selection (Not yet implemented)")
                        }) {
                            Image(systemName: "map.fill")
                        }
                    }
                }

                Section {
                    Button("Log Run") {
                        let newRun = Run(
                            date: runDate,
                            distance: distance,
                            time: totalTimeInSeconds,
                            pace: calculatedPace,
                            locationName: locationName
                        )
                        runManager.addRun(newRun)
                        dismiss()
                    }
                    .disabled(distance == 0 || totalTimeInSeconds == 0)
                }
            }
            .navigationTitle("Log New Run")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

extension TimeInterval {
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? "00:00:00"
    }

    var formattedPace: String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct LogRunView_Previews: PreviewProvider {
    static var previews: some View {
        LogRunView()
            .environmentObject(RunManager())
    }
}
