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
                        .toggleStyle(SwitchToggleStyle(tint: appData.account.accentTheme.mainColor))
                        .listRowBackground(appData.account.backgroundTheme.mainColor)
                    
                    HStack {
                        Text("Accent:")
                        Spacer()
                        AccentPickerAccountView(account: $appData.account)
                            .background(appData.account.backgroundTheme.mainColor)
                    }
                    .listRowBackground(appData.account.backgroundTheme.mainColor)
                    
                    BackgroundPickerView(selection: $appData.account.backgroundTheme)
                        .navigationBarTitleTextColor(appData.account.backgroundTheme.complementaryColor)
                        .listRowBackground(appData.account.backgroundTheme.mainColor)

                } // end of Section
                .background(appData.account.backgroundTheme.mainColor)
            } // end of List
            .listStyle(.plain)
            .background(appData.account.backgroundTheme.mainColor)
            .foregroundColor(appData.account.backgroundTheme.complementaryColor)
            .navigationTitle("Account Settings")
            .navigationBarTitleTextColor(appData.account.backgroundTheme.complementaryColor)
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Dismiss") {
                        isPresentingAccountView = false
                    }
                    .accessibilityLabel("Dismiss")
                }
            }
            .accentColor(appData.account.accentTheme.mainColor)
        } // end of NavigationView
        
    }
}

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}


#Preview {
    AccountSettingsView(isPresentingAccountView: .constant(true))
        .environmentObject(AppData())
}
