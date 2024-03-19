//
//  BottomTabView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/4/24.
//

import SwiftUI
struct BottomTabView: View { 
    @EnvironmentObject private var appData: AppData
    @State private var selectedTab: Int = 0

    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack {
                switch selectedTab {
                case 0:
                    HabitListView(habits: $appData.account.habits)
                case 1:
//                    HabitListView(habits: $appData.account.habits)
                    EmptyView()
                case 2:
                    StatsView()
                default:
                    EmptyView()
                }
            }
            
            Spacer()
            
            CustomTabs(index: $selectedTab)
                .background(appData.account.backgroundTheme.mainColor)
        }
        .background(appData.account.backgroundTheme.mainColor)
        .ignoresSafeArea()
    }
}

#Preview {
    BottomTabView()
        .environmentObject(AppData())
}

// // CustomTabBarView.swift // Custom TabView // // Created by Macbook on 4/7/23. //

import SwiftUI

struct CustomTabs: View { 
    @Binding var index: Int
    @State private var isPresentingNewHabitView = false
    @EnvironmentObject private var appData: AppData

    var body: some View {
        HStack {
            
            Spacer()
            
            Button(action: {
                self.index = 0
            }) {
                VStack {
                    if (self.index == 0) {
                        Image(systemName: "circle.grid.2x2.fill")
                            .font(.title)
                            .foregroundColor(appData.account.accentTheme.mainColor)
                    } else {
                        Image(systemName: "circle.grid.2x2")
                            .font(.title)
                            .foregroundColor(appData.account.accentTheme.mainColor)
                    }
//                    Text("Habits")
//                        .padding(.top, 5)
//                        .font(.system(size: 12))
//                        .foregroundColor(appData.account.backgroundTheme.mainColor)
                }
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                isPresentingNewHabitView = true
            }) {
                VStack {
                    Image(systemName: "plus")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(24)
                        .background(appData.account.accentTheme.mainColor)
                        .clipShape(Circle())
                    
//                    Text("New Habit")
//                        .font(.system(size: 12))
//                        .foregroundColor(appData.account.backgroundTheme.mainColor)
                }
            }
            .offset(y: -20)
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 2
            }) {
                VStack {
                    if (self.index == 2) {
                        Image(systemName: "chart.bar.fill")
                            .font(.title)
                            .foregroundColor(appData.account.accentTheme.mainColor)
                    } else {
                        Image(systemName: "chart.bar")
                            .font(.title)
                            .foregroundColor(appData.account.accentTheme.mainColor)
                    }
//                    Text("Stats")
//                        .padding(.top, 5)
//                        .font(.system(size: 12))
//                        .foregroundColor(appData.account.backgroundTheme.mainColor)
                }
            }
            
            Spacer()
        }
        .padding(.bottom, 10)

        .background(appData.account.backgroundTheme.complementaryColor.cornerRadius(20))
        .sheet(isPresented: $isPresentingNewHabitView) {
            NewHabitView(habits: $appData.account.habits, isPresentingNewHabitView: $isPresentingNewHabitView)
                .accentColor(appData.account.accentTheme.mainColor)
        }
    }
    
        
}
