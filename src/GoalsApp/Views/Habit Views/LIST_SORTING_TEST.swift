//
//  LIST_SORTING_TEST.swift
//  GoalsApp
//
//  Created by Garrison Creek on 4/11/24.
//

import SwiftUI

struct LIST_SORTING_TEST: View {
    @EnvironmentObject private var appData: AppData
    @Binding var habits: [Habit]
    
    @State private var isPresentingAccountView = false
    
    @State private var selectedHabit: Habit?
    @Namespace var namespace
    
    // show \ hide bools for list sections
    @State private var showDailyHabits = true
    @State private var showWeeklyHabits = true
    @State private var showMonthlyHabits = true
    @State private var showSkippedHabits = true
    
    // SORTING OPTIONS // TODO: IMPLEMENT THIS
    enum SortOption {
        case dueDate, dateCreated, priority
    }
    @State private var sortOption: SortOption = .priority

    var body: some View {
        
        List ($habits) {$habit in
            
            if (!appData.account.showCompletedHabits && habit.isComplete)
            HabitCardView(habit: $habit)
            
        }
        
        
        Text("Hello")
        
        
        
        
        
    }
}

#Preview {
    LIST_SORTING_TEST(habits: .constant(Habit.testHabits))
        .environmentObject(AppData())
}
