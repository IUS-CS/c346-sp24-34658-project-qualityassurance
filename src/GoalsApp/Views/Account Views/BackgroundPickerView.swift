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
        .pickerStyle(.navigationLink)
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
    }
}

#Preview {
    BackgroundPickerView(selection: .constant(BackgroundTheme.allCases[0]))
        .environmentObject(AppData())
}
