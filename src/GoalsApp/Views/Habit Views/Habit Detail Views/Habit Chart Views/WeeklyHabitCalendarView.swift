//
//  WeeklyHabitCalendarView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/22/24.
//

import SwiftUI

struct WeeklyHabitCalendarView: View {
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
                        if day.monthInt == date.monthInt && day.dayInt >= date.startOfWeek.dayInt && day.dayInt <= date.endOfWeek.dayInt - 1 {
                            
                            VStack {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(selectedHabit.theme.complementaryColor)
                                    .frame(maxWidth: .infinity)
                                
                                ZStack (alignment: .bottom) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Date.now.startOfDay == day.startOfDay ? selectedHabit.accent.mainColor: selectedHabit.theme.mainColor
                                                , lineWidth: 2)
                                        .frame(width: 20, height: 200)
                                    
                                    ZStack (alignment: .bottom) {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(selectedHabit.accent.mainColor)
                                            .frame(width: 18, height: calculateHeight(selectedHabit: selectedHabit, day: day))
                                    }
                                }
                            }
                            
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

func calculateHeight(selectedHabit: Habit, day: Date) -> CGFloat {
    var height = 0.0
    if selectedHabit.datesCompleted.contains(day.startOfDay) {
        height = 200.0
    } else if selectedHabit.missedDaysAmount[day.startOfDay] != nil {
        var missedPercentage = selectedHabit.missedDaysAmount[day.startOfWeek]!
        height = 200.0 * CGFloat(missedPercentage)
    }
    
    return height
}

#Preview {
    WeeklyHabitCalendarView(selectedHabit: Habit.testHabits[0])
        .environmentObject(AppData())
}
