

import SwiftUI
import SwiftData

@main
struct HabitTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            LandingScreen()
        }
        .modelContainer(for: Tasks.self)
    }
}
