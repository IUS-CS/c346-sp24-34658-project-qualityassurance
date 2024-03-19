//
//  AccentPickerView.swift
//  Notes
//
//  Created by Garrison Creek on 8/12/23.
//

import SwiftUI

struct AccentPickerView: View {
    @Binding var newHabit: Habit
    var body: some View {
        HStack {
            Spacer()
            ForEach(Accent.allCases) { accent in
                Button() {
                    newHabit.accent = accent
                } label: {
                    AccentView(accent: accent, selection: $newHabit.accent)
                        .shadow(radius: 3)
                }
            }
            Spacer()
        }
        
    }
}

struct AccentPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AccentPickerView(newHabit: .constant(Habit.testHabits[0]))
    }
}
