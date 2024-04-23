//
//  HabitCardView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/20/24.
//

import SwiftUI
import ConfettiSwiftUI

struct HabitCardView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var habit: Habit
    @State private var offset: CGFloat = 0
    @State private var isSelected = false
    
    @State private var fakeCounter: Int = 0
    
    var body: some View {
        
        let longPress = LongPressGesture(minimumDuration: 0.05)
            .onEnded { _ in
                isSelected = true
                appData.account.soundsEnabled ? SoundManager.instance.playSound(sound: appData.account.selectionSound): nil
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
                    habit.celebration += 1
                    appData.account.soundsEnabled ? SoundManager.instance.playSound(sound: appData.account.completionSound): nil
                }
                else if habit.isComplete && habit.currentAmount < habit.goalAmount {
                    habit.markIncomplete()
                    appData.account.soundsEnabled ? SoundManager.instance.playSound(sound: appData.account.failureSound): nil
                }
                isSelected = false
            }
        
        let combined = longPress.sequenced(before: drag)
        
        ZStack (alignment: .leading) {
            Rectangle()
                .fill(habit.theme.mainColor.secondary)
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
        .gesture(combined)
        .sensoryFeedback(.success, trigger: isSelected)
        .sensoryFeedback(.impact, trigger: habit.currentAmount)
//        .confettiCannon(counter: $habit.celebration)
        .confettiCannon(counter: appData.account.celebrationsEnabled ? $habit.celebration: $fakeCounter)
        
        
        .overlay(
            Image(systemName: habit.icon)
                .font(.largeTitle)
//                .resizable()
//                .frame(width: 30, height: 30)
                .padding(.leading, 280)
                .padding(.top, 40)
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
                        .padding(.top, 25)
                        .padding(.leading, 20)
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


struct HabitCardView_Previews: PreviewProvider {
    static var habit = Habit.testHabits[0]
    static var previews: some View {
        HabitCardView(habit: .constant(habit))
            .environmentObject(AppData())
    }
}
