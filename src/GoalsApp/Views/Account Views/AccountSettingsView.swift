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
                Section(header: Text("Account Info")) {
                    
                    Toggle("Recieve Notifications:", isOn: $appData.account.notificationsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: appData.account.accentTheme.standardColor))
                        .listRowBackground(appData.account.backgroundTheme.mainColor)
                    
                    HStack {
                        Text("Accent:")
                        Spacer()
                        AccentPickerAccountView(account: $appData.account)
                            .background(appData.account.backgroundTheme.mainColor)
                            .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                    }
                    .listRowBackground(appData.account.backgroundTheme.mainColor)
                    
                    BackgroundPickerView(selection: $appData.account.backgroundTheme)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                        .listRowBackground(appData.account.backgroundTheme.mainColor)

                } // end of Section
                .background(appData.account.backgroundTheme.mainColor)
            } // end of List
            .listStyle(.plain)
            .background(appData.account.backgroundTheme.mainColor)
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
