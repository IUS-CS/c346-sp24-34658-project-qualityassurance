//
//  ContentView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appData: AppData
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    @State private var selection: Tab = .habits

    enum Tab {
        case habits
        case newHabit
        case stats
    }
    
    var body: some View {
        
        BottomTabView()
            .background(appData.account.backgroundTheme.mainColor)
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

#Preview {
    ContentView(saveAction: {})
        .environmentObject(AppData())
}

