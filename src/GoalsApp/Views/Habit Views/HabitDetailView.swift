//
//  HabitDetailView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/20/24.
//

import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject private var appData: AppData
    @State var selectedHabit: Habit?
    let namespace: Namespace.ID
    
    var body: some View {
        
        ZStack () {
            VStack () { // first layer glassmorphism stack
                
                ScrollView () { // top layer item list stack
                    HStack {
                        Spacer()
                        HabitCardView(habit: $selectedHabit.toUnwrapped(defaultValue: Habit.emptyHabit))
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                            .matchedGeometryEffect(id: selectedHabit!.id, in: namespace, properties: .frame, anchor: .top, isSource: selectedHabit != nil)
                        Spacer()
                    }
                    .padding(.top)
                    
                    HabitCalendarView(selectedHabit: selectedHabit!)
                        .padding(.top)
                    
                    
                    
                    
                    
                    
                    Spacer()
                } // END OF SCROLLVIEW
                .clipped()
            }
            .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height - 200)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
        }
        
    }
}

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(selectedHabit: Habit.testHabits.first, namespace: Namespace().wrappedValue)
            .environmentObject(AppData())
    }
}



struct HabitCalendarView: View {
    @State var selectedHabit: Habit
    @State private var date = Date.now
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    
    var body: some View {
        ZStack {
            // background glass container
            Rectangle()
                .fill(selectedHabit.theme.mainColor.tertiary)
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
                        } else {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedHabit.theme.complementaryColor)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    Circle()
                                        .fill(selectedHabit.theme.mainColor)
                                        .stroke(Date.now.startOfDay == day.startOfDay ? selectedHabit.theme.complementaryColor: selectedHabit.theme.mainColor
                                            , lineWidth: 3)
                                )
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
}

extension Date {
    static var firstDayOfWeek = Calendar.current.firstWeekday
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        //           let weekdays = calendar.shortWeekdaySymbols
        
        //           return weekdays.map { weekday in
        //               guard let firstLetter = weekday.first else { return "" }
        //               return String(firstLetter).capitalized
        //           }
        // Adjusted for the different weekday starts
        var weekdays = calendar.shortWeekdaySymbols
        if firstDayOfWeek > 1 {
            for _ in 1..<firstDayOfWeek {
                if let first = weekdays.first {
                    weekdays.append(first)
                    weekdays.removeFirst()
                }
            }
        }
        return weekdays.map { $0.capitalized }
    }
       
       static var fullMonthNames: [String] {
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale.current

           return (1...12).compactMap { month in
               dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
               let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
               return date.map { dateFormatter.string(from: $0) }
           }
       }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
//    var sundayBeforeStart: Date {
//        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
//        let numberFromPreviousMonth = startOfMonthWeekday - 1
//        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
//    }
    // New to accomodate for different start of week days
    var firstWeekDayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        // Current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        // previous month days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
        
        // Fixed to accomodate different weekday starts
        return days.filter { $0 >= firstWeekDayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var yearInt: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    // Used to generate the mock data for previews
    // Computed property courtesy of ChatGPT
    var randomDateWithinLastThreeMonths: Date {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: self)!
        let randomTimeInterval = TimeInterval.random(in: 0.0..<self.timeIntervalSince(threeMonthsAgo))
        let randomDate = threeMonthsAgo.addingTimeInterval(randomTimeInterval)
        return randomDate
    }
}
