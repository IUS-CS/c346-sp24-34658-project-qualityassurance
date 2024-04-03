//
//  ExpandedHabitCardView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/23/24.
//

import SwiftUI

struct ExpandedHabitCardView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var habit: Habit
    @State private var offset: CGFloat = 0
    @State private var isSelected = false
    
    var body: some View {
        
        let longPress = LongPressGesture(minimumDuration: 0.1)
            .onEnded { _ in
                isSelected = true
            }
        
        let drag = DragGesture()
            .onChanged { value in
                withAnimation (.bouncy){
                    isSelected = true
                    if habit.goalAmount == 1 && value.translation.width > 0 {
                        habit.currentAmount = 1
                    } else {
                        let dragAmount = value.translation.width + offset
                        let totalWidth = UIScreen.main.bounds.width - 50
                        
                        let dragPercentage = dragAmount / totalWidth
                        let updatedAmount = dragPercentage * CGFloat(habit.goalAmount)
                        
                        let clampedAmount = min(max(updatedAmount, 0), CGFloat(habit.goalAmount))
                        
                        habit.currentAmount = Int(clampedAmount)
                    }
                }
            }
            .onEnded { value in
                offset = calcPercent()
                if habit.currentAmount == habit.goalAmount && !habit.isComplete{
                    habit.markComplete()
                }
                else if habit.isComplete && habit.currentAmount < habit.goalAmount {
                    habit.markIncomplete()
                }
                else {
                    
                }
                isSelected = false
            }
        
        let combined = longPress.sequenced(before: drag)
        
        ZStack (alignment: .leading) {
            Rectangle()
                .fill(habit.theme.mainColor.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .frame(height: 200)
                .frame(maxWidth: UIScreen.main.bounds.width - 50)
                .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
            
            
            ZStack (alignment: .trailing) {
                Rectangle()
                    .fill(habit.theme.mainColor)
                    .cornerRadius(15)
                    .frame(height: 200)
                    .frame(width: calcPercent())
            }
        }
        .scaleEffect(isSelected ? 1.02: 1)
        .gesture(combined)
        
        .overlay(
            Image(systemName: habit.icon)
                .resizable()
                .frame(width: 50, height: 60)
                .padding(.leading, 270)
                .padding(.top, 100)
                .foregroundColor(habit.accent.standardColor)
        )
        .overlay(
            HStack {
                VStack (alignment: .leading) {
                    Spacer()
                    Text("\(habit.title.uppercased())")
                        .font(.system(size: 30))
                        .font(.title)
                        .fontWeight(.black)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                        .padding(.leading, 20)
                        .monospaced()
                        .foregroundColor(habit.theme.complementaryColor)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    Text(habit.content)
                        .font(.subheadline)
                        .fontWeight(.black)
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                        .monospaced()
                        .foregroundColor(habit.theme.complementaryColor)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    if (habit.isSkipped) {
                        Text("\(habit.frequency.rawValue.uppercased()): SKIPPED")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .monospaced()
                            .padding(.leading, 20)
                            .padding(.bottom, 10)
                            .foregroundColor(habit.theme.complementaryColor.opacity(0.8))
                    } else {
                        Text("\(habit.frequency.rawValue.uppercased()): \(habit.dueDate.formatted(.dateTime.month(.defaultDigits).day(.defaultDigits)))")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .monospaced()
                            .padding(.leading, 20)
                            .padding(.bottom, 10)
                            .foregroundColor(habit.theme.complementaryColor.opacity(0.8))
                    }
                    
                    
                    
                }
                
                Spacer()
                
                VStack {
                    Text("\(habit.currentAmount) / \(habit.goalAmount)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                        .foregroundColor(habit.theme.complementaryColor)
                    Spacer()
                }
            }
        )
    }
    
    func calcPercent() -> CGFloat {
        let totalWidth = UIScreen.main.bounds.width - 50
        let percentage = CGFloat(habit.currentAmount) / CGFloat(habit.goalAmount)
        let width = totalWidth * percentage
        
        return width
    }
}


struct ExpandedHabitCardView_Previews: PreviewProvider {
    static var habit = Habit.testHabits[0]
    static var previews: some View {
        ExpandedHabitCardView(habit: .constant(habit))
            .environmentObject(AppData())
    }
}
