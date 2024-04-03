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
        
        ZStack {
            VStack {
                switch selection {
                case .habits: HabitListView(habits: $appData.account.habits)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)

                    
                case .newHabit: HabitListView(habits: $appData.account.habits)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)

                    
                case .stats: StatsView()
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                }
                Spacer()
                BottomTabBarView(selectedTab: $selection)
                    .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
            }
            .background(appData.account.backgroundTheme.mainColor)
        }

        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

#Preview {
    ContentView(saveAction: {})
        .environmentObject(AppData())
}

