//
//  AccountSettingsView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/12/24.
//

import SwiftUI

struct AccountSettingsView: View {
    @EnvironmentObject private var appData: AppData
    @State private var isPresentingEditView = false
    @Binding var isPresentingAccountView: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    
                    Toggle("Recieve Notifications:", isOn: $appData.account.notificationsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: appData.account.accentTheme.standardColor))
                        .onChange(of: appData.account.notificationsEnabled) { _ in
                            if appData.account.notificationsEnabled {
                                NotificationManager.instance.requestPermission()
                            } else {
                                NotificationManager.instance.cancelAllNotifications()
                            }
                        }
                    
                    Toggle("Celebration Confetti:", isOn: $appData.account.celebrationsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: appData.account.accentTheme.standardColor))
                    
                    Toggle("Audio Feeback:", isOn: $appData.account.soundsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: appData.account.accentTheme.standardColor))
                    
                    Toggle("Haptic Feedback:", isOn: $appData.account.hapticFeedbackEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: appData.account.accentTheme.standardColor))
                    
                    Toggle("Show Completed Habits:", isOn: $appData.account.showCompletedHabits)
                        .toggleStyle(SwitchToggleStyle(tint: appData.account.accentTheme.standardColor))
                        .onChange(of: appData.account.showCompletedHabits) { _ in
                            if !appData.account.showCompletedHabits {
                                appData.account.celebrationsEnabled = false
                            }
                        }
                    
                    
                    
                } // end of Section
                
                Section(header: Text("Colors")) {
                    VStack {
                        HStack {
                            Text("Accent:")
                            Spacer()
                        }
                        AccentPickerAccountView(account: $appData.account)
                            .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                    }
                    
                    BackgroundPickerView(selection: $appData.account.backgroundTheme)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)

                } // end of Section
                
                Section(header: Text("Sounds")) {
                    
                    AudioPickerView(selection: $appData.account.notificationSound, audioSetting: "Notification Sound:")
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                    
                    AudioPickerView(selection: $appData.account.completionSound, audioSetting: "Completion Sound: ")
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                    
                    AudioPickerView(selection: $appData.account.failureSound, audioSetting: "Failure Sound: ")
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                    
                    AudioPickerView(selection: $appData.account.selectionSound, audioSetting: "Selection Sound: ")
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)

                } // end of Section
            } // end of List
            .foregroundColor(appData.account.backgroundTheme.complementaryColor)
            .navigationTitle("Account Settings")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Dismiss") {
                        isPresentingAccountView = false
                    }
                    .accessibilityLabel("Dismiss")
                }
            }
            .accentColor(appData.account.accentTheme.standardColor)
        } // end of NavigationView
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
    }
}


#Preview {
    AccountSettingsView(isPresentingAccountView: .constant(true))
        .environmentObject(AppData())
}
