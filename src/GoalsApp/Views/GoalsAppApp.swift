//
//  GoalsAppApp.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import SwiftUI
import BackgroundTasks

@main
struct GoalsApp: App {
    @StateObject private var appData = AppData()
    @State private var errorWrapper: ErrorWrapper?
    
    @Environment(\.scenePhase) private var phase
    
    init() {
        NotificationManager.instance.requestPermission()
        UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: nil)
    }
    
    func scheduleAppRefresh() {
        let backgroundTask = BGAppRefreshTaskRequest(identifier: "BackgroundRefreshApp")
        
        // Define the date components for midnight
        var dateComponents = DateComponents()
        dateComponents.hour = 0 // Midnight
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.timeZone = .current
        
        // Get the next occurrence of midnight from the current date
        guard let nextMidnight = Calendar.current.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .nextTime) else {
            return
        }
        
        // Set the earliest begin date to the next occurrence of midnight
        backgroundTask.earliestBeginDate = nextMidnight
        
        // Submit the background task
        do {
            try BGTaskScheduler.shared.submit(backgroundTask)
            print("Scheduled background task refresh at \(nextMidnight)")
        } catch {
            print("Error scheduling background task: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            {
                Task {
                    do {
                        try await appData.save(account: appData.account)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                    appData.account.updateHabits()
                    print("SAVING HABIT UPDATE TEST...")
                }
            }
            .task {
                do {
                    try await appData.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Error: will load sample data and continue.")
                }
                appData.account.updateHabits()
                print("LOADING HABIT UPDATE TEST...")
            }
            .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
            .environmentObject(appData)
            .sheet(item: $errorWrapper) {
                appData.account.habits = Habit.testHabits
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .background: scheduleAppRefresh()
            default: break
            }
        }
        .backgroundTask(.appRefresh("BackgroundRefreshApp")) {
            // update all the habits
//            appData.account.updateHabits()
            print("inside .backgroundTask app refreshing in backgroudn here")
            // send local notification
            NotificationManager.instance.sendNotification(title: "App Refreshed", body: " ITS DOING ITS TING", time: Date())
        }
        
    }
}

