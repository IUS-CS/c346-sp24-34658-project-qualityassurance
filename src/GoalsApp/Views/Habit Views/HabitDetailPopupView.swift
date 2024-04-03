//
//  HabitDetailPopupView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/17/24.
//

import SwiftUI

struct HabitDetailPopupView: View {
    var body: some View {
        VStack {
            HabitDetailView(habit: .constant(Habit.testHabits[0]), isPresentingDetailView: .constant(true))
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
        .frame(maxWidth: UIScreen.main.bounds.width - 45)
        .frame(maxHeight: UIScreen.main.bounds.height - 150)
        
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailPopupView()
    }
}
