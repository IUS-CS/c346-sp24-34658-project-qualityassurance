////
////  HabitMinimizedView.swift
////  GoalsApp
////
////  Created by Garrison Creek on 3/14/24.
////
//
//import SwiftUI
//
//struct HabitMinimizedView: View {
//    @Binding var habit: Habit
//    
//    var body: some View {
//        NavigationLink( destination: HabitDetailView(habit: $habit)) {
//            // Pill shape
//            RoundedRectangle(cornerRadius: 35)
//                .frame(width: 50, height: 75)
//                .foregroundColor(habit.theme.mainColor)
//                .cornerRadius(35)
//                .shadow(radius: 5)
//            // label of streak number
//                .overlay(
//                    Image(systemName: habit.icon)
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(habit.accent.mainColor)
//                        .padding(.bottom, 25)
//                )
//                .overlay(
//                    Image(systemName: "flame.fill")
//                        .resizable()
//                        .frame(width: 15, height: 20)
//                        .foregroundColor(.red)
//                        .padding(.top, 35)
//                        .padding(.leading, 20)
//                )
//                .overlay(
//                    Text("\(habit.streak)")
//                        .foregroundColor(habit.theme.complementaryColor)
//                        .font(.body)
//                        .padding(.top, 35)
//                        .padding(.trailing, 20)
//                )
//        }
//        
//    }
//}
//
//#Preview {
//    HabitMinimizedView(habit: .constant(Habit.testHabits[0]))
//}
