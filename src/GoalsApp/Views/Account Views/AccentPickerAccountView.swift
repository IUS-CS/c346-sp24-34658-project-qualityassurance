//
//  AccentPickerAccountView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/12/24.
//

import SwiftUI

struct AccentPickerAccountView: View {
    @Binding var account: Account
    var body: some View {
        HStack {
            Spacer()
            ForEach(Accent.allCases) { accent in
                Button() {
                    account.accentTheme = accent
                } label: {
                    AccentView(accent: accent, selection: $account.accentTheme)
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    AccentPickerAccountView(account: .constant(Account()))
}
