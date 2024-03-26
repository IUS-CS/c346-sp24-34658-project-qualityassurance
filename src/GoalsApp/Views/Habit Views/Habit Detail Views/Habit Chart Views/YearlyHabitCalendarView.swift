//
//  YearlyHabitCalendarView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/22/24.
//

import SwiftUI

struct YearlyHabitCalendarView: View {
    @EnvironmentObject private var appData: AppData
    @State var selectedHabit: Habit
    @State private var date = Date.now
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    YearlyHabitCalendarView(selectedHabit: Habit.testHabits[0])
        .environmentObject(AppData())
}
