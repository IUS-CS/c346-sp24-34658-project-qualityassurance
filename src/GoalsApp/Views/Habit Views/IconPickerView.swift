//
//  IconPickerView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/19/24.
//

import SwiftUI

struct IconPickerView: View {
    @Binding var newHabit: Habit
    @Binding var isPresentingIconView: Bool
    @Binding var selection: String
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach (suggestedSymbols, id: \.self) { symbol in
                Button(action: {
                    selection = symbol
                    isPresentingIconView.toggle()
                }) {
                    Image(systemName: symbol)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(newHabit.accent.mainColor)
                        .frame(width: 30, height: 30)
                        .background(
                            Circle()
                                .foregroundStyle(newHabit.theme.mainColor.opacity(0.25))
                                .frame(width: 50, height: 50)
                        )
                        .padding(.top, 20)
                        .padding(.leading)
                        .padding(.trailing)
                }
            }
        }
        .padding()
    }
}

#Preview {
    IconPickerView(newHabit: .constant(Habit.testHabits[0]), isPresentingIconView: .constant(true), selection: .constant("bookmark.fill"))
}
