//
//  HabitCalendarView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/23/24.
//

import SwiftUI

struct HabitCalendarView: View {
    @EnvironmentObject private var appData: AppData
    @State var selectedHabit: Habit?
    
    
    var body: some View {
        
    }
}

#Preview {
    HabitCalendarView()
        .environmentObject(AppData())
}
