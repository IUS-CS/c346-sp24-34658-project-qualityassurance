//
//  ProgressBarChartView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 4/24/24.
//

import SwiftUI

struct ProgressBarChartView: View {
    @EnvironmentObject private var appData: AppData
    
    @State private var date = Date.now
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    var body: some View {
        ZStack { // Productivity Graph
            Rectangle()
                .fill(appData.account.backgroundTheme.mainColor.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .frame(width: (UIScreen.main.bounds.width - 25))
                .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
            
            VStack {
                Text("Daily Habit Completions")
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    .padding(.top, 10)
                
                // Bar Chart showing daily habit completions for the current week
                VStack {
                    LazyVGrid(columns: columns) {
                        ForEach(days, id: \.self) { day in
                            if day.monthInt == date.monthInt && day.dayInt >= date.dayInt - 6 && day.dayInt <= date.dayInt {
                                VStack {
                                    let totalCompletions = CGFloat(appData.account.totalCompletionsForDay(day: day))
                                    let totalPossible = CGFloat(appData.account.totalPossibleCompletionsForDay(day: day))
                                    let completionRate = totalPossible > 0 ? (totalCompletions / totalPossible) : 0
                                    let barHeight = completionRate * 145
                                    
                                    
                                    Spacer()
                                    Text("\(Int(totalCompletions))")
                                        .padding(0)
                                        .font(.caption)
                                        .fontWeight(.black)
                                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                    
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(appData.account.accentTheme.mainColor)
                                            .frame(height: barHeight) // Adjusted bar height
                                    
                                    
                                    Text(day.formatted(.dateTime.day()))
                                        .fontWeight(.black)
                                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                        .frame(maxWidth: .infinity)
                                }
                                .frame(height: 200)
                            }
                        }
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                .onAppear {
                    days = date.calendarDisplayDays
                }
                .onChange(of: date) {
                    days = date.calendarDisplayDays
                }
            }
        } // Productivity Graph
        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 225)
    }
}

#Preview {
    ProgressBarChartView()
        .environmentObject(AppData())
}
