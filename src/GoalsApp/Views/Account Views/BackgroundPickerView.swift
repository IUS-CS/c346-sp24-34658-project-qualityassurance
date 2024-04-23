//
//  BackgroundPickerView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/12/24.
//

import SwiftUI

struct BackgroundPickerView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var selection: BackgroundTheme
    
    var body: some View {
        Picker("Background:", selection: $selection) {
            ForEach(BackgroundTheme.allCases) { theme in
                Text(theme.name)
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(theme.mainColor)
                    .foregroundColor(theme.complementaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .tag(theme)
            }
        }
        // when a background is selected check if the accent color is the same color and change it if it is
        .onChange(of: selection) { _ in
            if appData.account.accentTheme == .Light && selection == .Light {
                appData.account.accentTheme = .Dark
            } else if appData.account.accentTheme == .Dark && selection == .Dark {
                appData.account.accentTheme = .Light
            }
        }
        
        .pickerStyle(.navigationLink)
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
    }
}

#Preview {
    BackgroundPickerView(selection: .constant(BackgroundTheme.allCases[0]))
        .environmentObject(AppData())
}
