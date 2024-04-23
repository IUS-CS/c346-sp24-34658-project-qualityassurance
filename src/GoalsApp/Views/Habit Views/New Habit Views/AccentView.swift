//
//  AccentView.swift
//  Goals
//
//  Created by Garrison Creek on 2/4/24.
//

import SwiftUI

struct AccentView: View {
    var accent: Accent
    @Binding var selection: Accent
    @EnvironmentObject private var appData: AppData
    
    var body: some View {
        
        VStack {
            Button(action: {
                selection = accent
                print("accent selected: \(accent.name)")
            }) {
                if accent == selection {
                    Circle()
                        .stroke(appData.account.backgroundTheme.complementaryColor, lineWidth: 0.1)
                        .background(Circle().fill(.white).frame(width:6,height:6))
                        .background(Circle().fill(accent.mainColor))
                        .frame(width: 25, height: 25)
                    
                } else {
                    Circle()
                        .stroke(appData.account.backgroundTheme.complementaryColor, lineWidth: 0.1)
                        .background(Circle().fill(accent.mainColor))
                        .frame(width: 25, height: 25)
                }
            }
        }
        
    }
}

struct AccentView_Previews: PreviewProvider {
    static var previews: some View {
        AccentView(accent: .accentBlue, selection: .constant(.accentBlue))
            .environmentObject(AppData())
    }
}
