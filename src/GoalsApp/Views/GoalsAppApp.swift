//
//  GoalsAppApp.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import SwiftUI

@main
struct GoalsApp: App {
    @StateObject private var appData = AppData()
    @State private var errorWrapper: ErrorWrapper?
    
    init() {
        NotificationManager.instance.requestPermission()
        UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: nil)
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
                }
            }
            .task {
                do {
                    try await appData.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Error: will load sample data and continue.")
                }
            }
            .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
            .environmentObject(appData)
            .sheet(item: $errorWrapper) {
                appData.account.habits = Habit.testHabits
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}

