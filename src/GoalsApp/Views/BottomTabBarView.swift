//
//  BottomTabBarView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/19/24.
//

import SwiftUI

struct BottomTabBarView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var selectedTab: ContentView.Tab
    @State private var isPresentingNewHabitView = false
    
    var body: some View {
        HStack {
            Spacer()
            Image(
                systemName:
                    selectedTab == .habits ?
                "circle.grid.2x2.fill" :
                    "circle.grid.2x2"
            )
            .imageScale(.large)
            .scaleEffect(selectedTab == .habits ? 1.25 : 1.0)
            .foregroundColor(selectedTab == .habits ? appData.account.accentTheme.standardColor : appData.account.backgroundTheme.complementaryColor)
            .onTapGesture {
                selectedTab = .habits
            }
            Spacer()
            Spacer()
            Image(
                systemName:
                    selectedTab == .newHabit ?
                "plus.circle.fill" :
                    "plus.circle"
            )
            .imageScale(.large)
            .scaleEffect(selectedTab == .newHabit ? 1.25: 1.0)
            .font(.largeTitle)
            .foregroundColor(selectedTab == .newHabit ? appData.account.accentTheme.standardColor : appData.account.backgroundTheme.complementaryColor)
            .onTapGesture {
                    selectedTab = .newHabit
                isPresentingNewHabitView = true
            }
            Spacer()
            Spacer()
            Image(
                systemName:
                    selectedTab == .stats ?
                "chart.bar.fill" :
                    "chart.bar"
            )
            .imageScale(.large)
            .scaleEffect(selectedTab == .stats ? 1.25: 1.0)
            .foregroundColor(selectedTab == .stats ? appData.account.accentTheme.standardColor : appData.account.backgroundTheme.complementaryColor)
            .onTapGesture {
                    selectedTab = .stats
            }
            Spacer()
        }
        .background(.regularMaterial)
        .frame(width: UIScreen.main.bounds.width - 100, height: 60)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
        
        .sheet(isPresented: $isPresentingNewHabitView) {
            NewHabitView(habits: $appData.account.habits, isPresentingNewHabitView: $isPresentingNewHabitView)
                .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                .accentColor(appData.account.accentTheme.standardColor)
                .onDisappear() {
                    selectedTab = .habits
                }
        }
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)

    }
}

#Preview {
    BottomTabBarView(selectedTab: .constant(.habits))
        .environmentObject(AppData())
}
