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
                
                if account.backgroundTheme == .Light && accent == .Light {
                    
                } else if account.backgroundTheme == .Dark && accent == .Dark {
                    
                } else {
                    Button() {
                        account.accentTheme = accent
                    } label: {
                        AccentView(accent: accent, selection: $account.accentTheme)
                    }
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    AccentPickerAccountView(account: .constant(Account()))
}
