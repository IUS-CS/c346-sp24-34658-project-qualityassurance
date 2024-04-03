//
//  MonthlyHabitCalendarView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/22/24.
//

import SwiftUI

struct MonthlyHabitCalendarView: View {
    @EnvironmentObject private var appData: AppData
    @State var selectedHabit: Habit
    @State private var date = Date.now
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    var body: some View {
        ZStack {
            // background glass container
            Rectangle()
                .fill(selectedHabit.theme.mainColor.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .frame(width: UIScreen.main.bounds.width - 50)
                .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
            
            VStack {
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .fontWeight(.black)
                            .foregroundStyle(selectedHabit.theme.complementaryColor)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: columns) {
                    ForEach(days, id: \.self) { day in
                        if day.monthInt != date.monthInt {
                            Text("")
                        }
                        else if (selectedHabit.datesCompleted.contains(day.startOfDay)) {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 38)
                                .background(
                                    Circle()
                                        .fill(selectedHabit.accent.mainColor)
                                        .stroke(Date.now.startOfDay == day.startOfDay ? selectedHabit.accent.mainColor: selectedHabit.theme.mainColor
                                                , lineWidth: 3)
                                )
                        }
                        else {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 38)
                                .background(
                                    Circle()
                                        .fill(selectedHabit.theme.mainColor.secondary)
                                        .stroke(Date.now.startOfDay == day.startOfDay ? selectedHabit.accent.mainColor: selectedHabit.theme.mainColor
                                                , lineWidth: 3)
                                )
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                days = date.calendarDisplayDays
            }
            .onChange(of: date) {
                days = date.calendarDisplayDays
            }
            
        }
        
        
    }
}

#Preview {
    MonthlyHabitCalendarView(selectedHabit: Habit.testHabits[0])
        .environmentObject(AppData())
}
