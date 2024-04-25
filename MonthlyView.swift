import SwiftUI
struct MonthlyView: View {
    @State private var currentDate = Date()
    @Binding var count : String
    private let weekDays = Calendar.current.shortWeekdaySymbols
    @Binding var days : [Int]

    var body : some View {
        VStack {
            Text (getMonthYear())
                .font(.title3)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                ForEach(0..<7){ index in
              
                    Text(weekDays[index].prefix(2))
                        .foregroundStyle(.white)
                }
                
                ForEach(Array(getCalendarDays().enumerated()), id: \.offset){ index, day in
                    DateView(day: day, isCurrentMonth: isCurrentMonth(day: day), isToday: false, days: $days)
                }
            }.padding(.horizontal)
            TextField("Enter the number of month you want to work on this habit", text: $count)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                    
        }
    }
    
    private func getMonthYear()-> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: currentDate)
    }
    
    private func getCalendarDays() -> [Date]{
        let calendar = Calendar.current
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year,.month], from: calendar.startOfDay(for: currentDate)))!
        let startDate = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: firstDayOfMonth), to: firstDayOfMonth)!
        let endDate = calendar.date(byAdding: .day, value: 41, to: startDate)!
        
        let firstWeekdayComponents = DateComponents(
            hour: 0,
            minute: 0,
            second: 0,
            nanosecond: 0)
    
        return calendar.generateDates(inside: startDate ... endDate, matching: firstWeekdayComponents, matchingPolicy: .nextTime)!
    }
    
    private func isCurrentMonth(day : Date) -> Bool {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: day)
        let month = calendar.component(.month, from: day)
        
        return currentYear == year && currentMonth == month
    }
}

struct DateView : View {
    let day : Date
    let isCurrentMonth : Bool
    let isToday : Bool
    @State var isSelected : Bool = false
    @Binding var days : [Int]
    
    var body : some View {
        Button(action: {
            isSelected.toggle()
            let date = Calendar.current.component(.day, from: day)
            if (isCurrentMonth)
            {
                if (isSelected) {
                    days.append(date)
                } else  { 
                    if let j = days.firstIndex(of: date)
                    {
                        days.remove(at: j)
                    }
                }
            }
        }){
            Text("\(Calendar.current.component(.day, from: day))")
                .frame(width: 30, height:  30)
                .background(isCurrentMonth ? (isSelected ? Color.yellow : Color.white.opacity(0.5)):
                    (isSelected ? Color.yellow : Color.black.opacity(0.2)))
                .foregroundColor(isToday ? Color.black : Color .purple)
                .cornerRadius(8)
        }
    }
    
}


extension Calendar {
    func generateDates (inside interval : ClosedRange<Date>, matching component: DateComponents, matchingPolicy : Calendar.MatchingPolicy) -> [Date]?{
        var dates : [Date] = []
        enumerateDates(startingAfter: interval.lowerBound, matching: component, matchingPolicy: matchingPolicy) { date, _ , stop in
            if let date = date,  date  <= interval.upperBound
            {
                dates.append(date)
                
            } else {
                stop = true
            }
        }
        return dates.isEmpty ? nil : dates
    }
}
