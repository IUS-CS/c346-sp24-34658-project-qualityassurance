//
//  ThemePickerView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/12/24.
//

import SwiftUI

struct ThemePickerView: View {
    @Binding var selection: HabitTheme
    @EnvironmentObject private var appData: AppData
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(HabitTheme.allCases) { theme in
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
    ThemePickerView(selection: .constant(HabitTheme.allCases[0]))
        .environmentObject(AppData())
}
