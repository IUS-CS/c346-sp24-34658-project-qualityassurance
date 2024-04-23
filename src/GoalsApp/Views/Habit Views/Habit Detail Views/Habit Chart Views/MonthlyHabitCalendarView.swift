//
//  MonthlyHabitCalendarView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/22/24.
//

import SwiftUI

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX-4, y: rect.minY, width: rect.width*1.2, height: 3))
            case .bottom: return Path(.init(x: rect.minX-4, y: rect.maxY - width, width: rect.width*1.2, height: width))
            case .leading: return Path(.init(x: rect.minX+(0.5*rect.maxX), y: rect.minY, width: rect.width/2 + 4, height: width))
            case .trailing: return Path(.init(x: rect.minX+(0.5*rect.maxX), y: rect.maxY - width, width: rect.width/2 + 4, height: width))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct MonthlyHabitCalendarView: View {
    @EnvironmentObject private var appData: AppData
    @State var selectedHabit: Habit
    @State private var date = Date.now
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    var body: some View {
        ZStack {
            // background glass container
            Rectangle()
                .fill(selectedHabit.theme.mainColor.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .frame(width: UIScreen.main.bounds.width - 50)
                .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
            
            VStack {
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .fontWeight(.black)
                            .foregroundStyle(selectedHabit.theme.complementaryColor)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: columns) {
                    ForEach(days, id: \.self) { day in
                        if day.monthInt != date.monthInt {
                            Text("")
                        }
                        else if (selectedHabit.period.start == day.startOfDay && selectedHabit.frequency != .daily) {
                            //Start of currentPeriod
                            ZStack {
                                if (selectedHabit.isComplete) {
                                    Circle()
                                        .fill(selectedHabit.accent.mainColor)
                                        .frame(width: 38, height: 38)
                                    Rectangle()
                                        .fill(selectedHabit.accent.mainColor)
                                        .frame(height: 38)
                                        .offset(x: 16)
                                        .ignoresSafeArea()
                                }
                                
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(selectedHabit.theme.complementaryColor)
                                    .frame(maxWidth: .infinity, minHeight: 38)
                                    .background(
                                        Arc(startAngle: .degrees(270), endAngle: .degrees(90), clockwise: true)
                                            .stroke(selectedHabit.accent.mainColor, lineWidth: 3)
                                            .border(width: 3, edges: [.leading, .trailing], color: selectedHabit.accent.standardColor)
                                    )
                            }
                        }
                        
                        else if (selectedHabit.period.start < day.startOfDay && selectedHabit.period.end > day.startOfDay && selectedHabit.frequency != .daily) {
                            // Inbetween current period
                            ZStack {
                                if (selectedHabit.isComplete) {
                                    Rectangle()
                                        .fill(selectedHabit.accent.mainColor)
                                        .overlay(
                                            Rectangle()
                                                .fill(selectedHabit.accent.mainColor)
                                                .frame(width: 50)
                                        )
                                }
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(selectedHabit.theme.complementaryColor)
                                    .frame(maxWidth: .infinity, minHeight: 38)
                                    .border(width: 3, edges: [.top, .bottom], color: selectedHabit.accent.standardColor)
                            }
                        }
                        else if (selectedHabit.period.end == day.startOfDay && selectedHabit.frequency != .daily) {
                            // End of current period
                            ZStack {
                                if (selectedHabit.isComplete) {
                                    Circle()
                                        .fill(selectedHabit.accent.mainColor)
                                        .frame(width: 38, height: 38)
                                    Rectangle()
                                        .fill(selectedHabit.accent.mainColor)
                                        .frame(width: 20, height: 38)
                                        .offset(x: -14)
                                        .ignoresSafeArea()
                                }
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(selectedHabit.theme.complementaryColor)
                                    .frame(maxWidth: .infinity, minHeight: 38)
                                    .background(
                                        Arc(startAngle: .degrees(270), endAngle: .degrees(90), clockwise: true)
                                            .stroke(selectedHabit.accent.mainColor, lineWidth: 3)
                                            .border(width: 3, edges: [.leading, .trailing], color: selectedHabit.accent.standardColor)
                                            .rotationEffect(.degrees(180))
                                    )
                            }
                        }
                        else if (selectedHabit.skippedDays.contains(day.startOfDay)  && selectedHabit.frequency == .daily) {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 38)
                                .background(
                                    // moon.zzz sf icon
                                    Image(systemName: "moon.zzz.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.purple)
                                )
                        } else if Date.now.startOfDay == day.startOfDay {
                            // For Daily Habits Current Day Outline
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 38)
                                .background(
                                    Circle()
                                        .stroke(selectedHabit.accent.mainColor, lineWidth: 3)
                                )
                        } 
                        else if (selectedHabit.datesCompleted.contains(day.startOfDay) && selectedHabit.frequency == .daily) {
                            // for daily habits showing completed past days
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 38)
                                .background(
                                    Circle()
                                        .fill(selectedHabit.accent.mainColor)
                                        .stroke(Date.now.startOfDay == day.startOfDay ? selectedHabit.accent.mainColor: selectedHabit.accent.mainColor
                                                , lineWidth: 3)
                                )
                        }
                        else if selectedHabit.missedDays_andAmount.keys.contains(day.startOfDay) {
                            // For Missed Habits placing X over day
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 38)
                                .background(
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.red)
                                )
                        }
                        else {
                            // For Habits, just the day number
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 38)
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                days = date.calendarDisplayDays
            }
            .onChange(of: date) {
                days = date.calendarDisplayDays
            }
            
        }
        
        
    }
    struct Arc: Shape {
        var startAngle: Angle
        var endAngle: Angle
        var clockwise: Bool
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: (min(rect.width, rect.height) / 2) - 1.5 , startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
            
            return path
        }
    }
}
extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}


#Preview {
    MonthlyHabitCalendarView(selectedHabit: Habit.testHabits[1])
        .environmentObject(AppData())
}
