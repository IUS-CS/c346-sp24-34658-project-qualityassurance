//
//  HabitCardView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/20/24.
//

import SwiftUI

struct HabitCardView: View {
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
                        habit.markComplete() // Mark as complete if goal amount is 1 and swiping right
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
                if habit.currentAmount == habit.goalAmount {
                    habit.markComplete()
                }
                isSelected = false
            }
        
        let combined = longPress.sequenced(before: drag)
        
        ZStack (alignment: .leading) {
            Rectangle()
                .fill(habit.theme.mainColor.secondary)
                .stroke(appData.account.backgroundTheme.complementaryColor, lineWidth: 1)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .frame(height: 100)
                .frame(maxWidth: UIScreen.main.bounds.width - 50)
                .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
            
            
            ZStack (alignment: .trailing) {
                Rectangle()
                    .fill(habit.theme.mainColor)
                    .cornerRadius(15)
                    .frame(height: 100)
                    .frame(width: calcPercent())
            }
        }
        .scaleEffect(isSelected ? 1.02: 1)
//        .onTapGesture { print("Tap") }
        .gesture(combined)
        
        .overlay(
            Image(systemName: habit.icon)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.leading, 280)
                .padding(.top, 40)
                .foregroundColor(habit.accent.mainColor)
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
                        .padding(.top, 25)
                        .padding(.leading, 20)
                        .monospaced()
                        .foregroundColor(habit.theme.complementaryColor)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    Text("\(habit.frequency.rawValue.uppercased()): \(habit.dueDate.formatted(.dateTime.month(.defaultDigits).day(.defaultDigits)))")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .monospaced()
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                        .foregroundColor(habit.theme.complementaryColor.opacity(0.8))
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


struct HabitCardView_Previews: PreviewProvider {
    static var habit = Habit.testHabits[0]
    static var previews: some View {
        HabitCardView(habit: .constant(habit))
            .environmentObject(AppData())
    }
}
