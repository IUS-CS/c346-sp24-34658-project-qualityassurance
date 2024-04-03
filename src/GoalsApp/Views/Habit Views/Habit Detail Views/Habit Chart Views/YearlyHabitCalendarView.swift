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
    
    let monthsOfYear = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let rows = Array(repeating: GridItem(.flexible()), count: 12)
    @State private var months: [Date] = []
    
    var body: some View {
        ZStack {
            // background glass container
            Rectangle()
                .fill(selectedHabit.theme.mainColor.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .frame(width: UIScreen.main.bounds.width - 50)
                .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
            
            
            VStack (alignment: .leading) {
                ForEach(monthsOfYear, id: \.self) { month in
                    HStack {
                        Spacer()
                        Text(month)
                            .fontWeight(.black)
                            .foregroundStyle(selectedHabit.theme.complementaryColor)
                        
                        Spacer()
                        ZStack (alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(month == date.formatted(.dateTime.month()) ? selectedHabit.accent.mainColor: selectedHabit.theme.mainColor, lineWidth: 2)
                                .frame(width: 250, height: 20)
                            
                            ZStack (alignment: .trailing) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill (selectedHabit.accent.mainColor)
                                    .frame(width: calculateWidth(selectedHabit: selectedHabit, month: month), height: 17)
                            }
                            .padding(.leading,1)
                        }
                        Spacer()
                    }
                }
                .padding(.top, 3)
                .padding(.bottom, 3)
            }
            .frame(height: 400)
            .frame(width: UIScreen.main.bounds.width - 50)
            .padding()
            .onAppear {
                months = date.calendarDisplayDays
            }
            .onChange(of: date) {
                months = date.calendarDisplayDays
            }
            
        }
        
        
    }
}

func calculateWidth(selectedHabit: Habit, month: String) -> CGFloat {
    var width = 0.0
    // TODO: IMPLEMENT THIS AFTER IMPLEMENTING THE DATA COLLECTION IN HABIT FILE
    width = Double.random(in: 0...250)
    
    
    
    return width
}

#Preview {
    YearlyHabitCalendarView(selectedHabit: Habit.testHabits[0])
        .environmentObject(AppData())
}
