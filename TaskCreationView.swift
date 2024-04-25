import SwiftUI
struct TaskCreationView: View {
    @Binding var displayTaskCreationView : Bool
//    @Binding var tasks : [Tasks]
    @State private var description : String = ""
    @State private var taskImage : String = "bicycle"
    @State private var selectedOption = FrequencyType.daily
    @State private var displayImageSelectionView = false
    let startDate:  Date = Date()
    @State private var  settingDetent = PresentationDetent.medium
    @State private var count : String = "1"
    @State private var days : [Int] = []
    @State private var seletedTime = Date()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    ZStack(alignment: .bottomTrailing) {
                        Image(taskImage)
                            .resizable()
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.white)
                        
                        Button(action: {
                            displayTaskCreationView = true
                        }) {
                            Image(systemName: "pencil,circle,fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.yellow)
                                .frame(width: 25, height: 25)
                                .alignmentGuide(.bottom){ d in d[.bottom]
                                }
                        }
                        
                    }
                    TextField("Enter details of task", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
            }.padding(.leading,20)
                
            DatePicker("Select a time", selection: $seletedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .foregroundColor(.white)
                    .padding(.leading,20)
            
            Picker("Slect an option", selection: $selectedOption){
                ForEach(FrequencyType.allCases){freq in
                    Text(freq.rawValue.capitalized)
                        .tag(freq)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedOption == FrequencyType.daily {
                    DaysView(count: count, days: $days)
                    
                }else if selectedOption == FrequencyType.weekly {
                    VStack {
                        HStack(spacing : 5) {
                            ForEach(0..<7){ index in
                                let date = Calendar.current.date (byAdding: .day, value: index, to: startDate) 
                                    ?? Date()
                                DayView(date: date, days: $days)
                            }
                            
                        }
                        TextField("Enter the number of week you want to work on this habit", text: $count)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                } else {
                    MonthlyView (count: $count, days: $days)
                    
                }
                Spacer()
                Button(action: {
                    displayTaskCreationView = false
                    var task = Tasks(name: description, frequencyType: selectedOption.rawValue, frequency: Int(count)!, imageName: taskImage, days: days)
                    task = Notification().scheduleNotification(task: task, time: seletedTime)
                    if task.frequency <= 1 {
                        task.totalDays = task.days.count
                    }
                    modelContext.insert(task)
                }) {
                    Text("Create Task")
                        .frame(width: 300, height: 40)
                        .background(Color.white)
                        .foregroundColor(.purple)
                        .cornerRadius(10)
                    
                }

            }
        }.background(Color.purple)
            .sheet(isPresented: $displayTaskCreationView, onDismiss:{})
        {
            ImageSelectionView(taskImage: $taskImage, isPresented: $displayImageSelectionView)
                .presentationDetents([.medium, .large], selection: $settingDetent)
        }
            
    }
}

struct DayView : View {
    let date : Date
    @State var isSelected = false
    @Binding var days : [Int]
    
    private let weekDays = Calendar.current.shortWeekdaySymbols
    
    
    var body : some View{
        
            Button(action: {
                isSelected.toggle()
                let dayName = dayOfWeekFormatter.string(from: date)
                if let i = weekDays.firstIndex(of: dayName)
                {
                    if (isSelected)
                    {
                        days.append(i+1)
                        
                    }else {
                        if let j = days.firstIndex(of: i+1)
                        {
                            days.remove(at: j)
                        }
                    }
                }
            }){
                VStack {
                    Text(dayOfWeekFormatter.string(from: date))
                    Text(dayFormatter.string(from: date))
                }.foregroundColor(.purple)
            }
            
            .frame(width: 50, height: 80)
            .background(isSelected ? Color.yellow : Color.white)
            .cornerRadius(10)
        
        
    }
    
    private let dayOfWeekFormatter : DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter

    } ()
    
    private let dayFormatter : DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    } ()

}


struct DaysView : View {
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @State var isSelected = [false, false, false, false, false, false, false]
    @State  var count : String
    @Binding var days : [Int]
    
    var body : some View {
        HStack(spacing : 10){
            ForEach(0..<daysOfWeek.count){ index in
                Button(action: {
                    isSelected[index].toggle()
                    if isSelected[index]
                    {
                        days.append(index+1)
                    } else {
                        if let i = days.firstIndex(of: index+1) {
                            days.remove(at: i)
                        }
                            
                    }
                }){
                    Text(daysOfWeek[index].prefix(2))
                        .foregroundColor(.purple)
                                    
        
                }.frame(width: 40, height: 40)
                    .background(isSelected[index] ? Color.yellow: Color.white)
                    .cornerRadius(20)
            }
        }
        .padding()
        TextField("Enter the number of days you want to work on this habit", text: $count)
            .keyboardType(.numberPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}
