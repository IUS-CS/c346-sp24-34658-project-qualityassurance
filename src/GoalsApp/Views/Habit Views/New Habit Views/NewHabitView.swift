//
//  NewHabitView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/3/24.
//

import SwiftUI

struct NewHabitView: View {
    @EnvironmentObject private var appData: AppData
    @State private var newHabit = Habit.emptyHabit
    @Binding var habits: [Habit]
    @Binding var isPresentingNewHabitView: Bool
    @State private var selectedFrequency = Habit.Frequency.daily
    @State private var isPresentingIconView = false
    
    @State private var isShowingHelpAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    //    enum Days: String, Codable, CaseIterable {
    //        case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    //    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                // ICON AND THEME SECTION
                Section(header: Text("Habit Icon") ){
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresentingIconView.toggle()
                        }) {
                            Image(systemName: newHabit.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .foregroundColor(newHabit.accent.standardColor)
                                .sheet(isPresented: $isPresentingIconView, content: {
                                    IconPickerView(selection: $newHabit.icon, title: "Choose your symbol", autoDismiss: true)
                                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                }).padding()
                        }
                        Spacer()
                    }
                    AccentPickerView(newHabit: $newHabit)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                    
                    //Habit Theme Picker
                    NavigationLink(destination: ThemePickerView(selection: $newHabit.theme).preferredColorScheme(appData.account.backgroundTheme.colorScheme)) {
                        HStack {
                            Text("Theme:")
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(newHabit.theme.mainColor)
                                .frame(width: 200, height: 30)
                                .overlay(
                                    Text(newHabit.theme.name)
                                        .font(.headline)
                                        .foregroundStyle(newHabit.theme.complementaryColor)
                                )
                            Spacer()
                        }
                    }
                }
                
                //General Info Section
                Section(header:
                    HStack {
                        Text("Habit Info")
                        Spacer()
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .onTapGesture {
                                alertTitle = "Info Section Help"
                                alertMessage = "The Unit name refers to the smallest measurement of your habit. For example a habit for running everyday may choose to use the unit name 'miles' along with a goal amount of 2, for 2 miles daily. \n \n The To-Do and To-Not-Do section is for marking a habit as something you want to NOT do rather than to do. For example you may make a habit to Not smoke everyday."
                                isShowingHelpAlert = true
                            }
                    }
                ) {
                    TextField("Title:", text: $newHabit.title)
                    TextField("Description:", text: $newHabit.content)
                    
                    Picker("Unit Name:", selection: $newHabit.unitName) {
                        ForEach(Habit.Units.allCases, id: \.self) {unit in
                            if unit == .none {
                                Text("None").tag(unit.rawValue)
                            } else {
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }
                    }
                    
                    // priority selector
                    Picker("Priority: \(newHabit.priority.rawValue)", selection: $newHabit.priority) {
                        ForEach(Habit.Priority.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    // ToDo OR Not ToDo
                    Picker("Type", selection: $newHabit.toDo) {
                        Text("To-Do").tag(true)
                        Text("To-Not-Do").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                } // END of Info Section
                
                // Frequency and Amounts Section
                Section(header: Text("Habit Frequency and Amounts")) {
                    Picker("Frequency", selection: $newHabit.frequency) {
                        ForEach(Habit.Frequency.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack {
                        Text("Goal Amount:")
                        Spacer()
                        TextField("Enter Value", value: $newHabit.goalAmount, formatter: NumberFormatter())
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minWidth: 15, maxWidth: 60)
                            .alignmentGuide(.controlAlignment) { $0[.leading] }
                        Spacer()
                        Stepper("Goal Amount:", value: $newHabit.goalAmount, in: 1...100)
                            .labelsHidden()
                    }
                    .alignmentGuide(.leading) { $0[.controlAlignment] }
                    
                }
                
                // Date Section
                Section(header:
                        HStack {
                    Text("Dates and Times")
                    Spacer()
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .onTapGesture {
                                    alertTitle = "Dates and Times Section Help"
                                    alertMessage = "The due date you select for your habit will default to the end of the day at the selected day. This means that if you set it for tomorrow, you will have until the end of the day tomorrow to complete it. \n \n For daily habits the active days selection allow you to choose which days of the week the habit is active for. For example, de-selecting saturday and sunday will make the habit be due every weekday rather than everyday of the week. \n \n Selecting an end date for your habit will remove the habit after you reach its end date. This is usefull for habits that are temporary or for a set period of time."
                                    isShowingHelpAlert = true
                                }
                        }
                ) {
                    DatePicker("Due Date:", selection: $newHabit.dueDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    // Exemption Days for Daily Habits
                    if newHabit.frequency == .daily {
                        VStack  {
                            HStack {
                                Text("Active Days:")
                                Spacer()
                            }
                            .padding(.bottom, 10)
                            
                            HStack {
                                Spacer()
                                ForEach(Habit.Days.allCases, id: \.self) { day in
                                    if newHabit.activeDays.contains(day) {
                                        Text(String(day.rawValue.first!))
                                            .fontWeight(.black)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Circle()
                                                    .fill(newHabit.accent.mainColor)
                                                    .frame(width: 35, height: 35)
                                            )
                                            .onTapGesture {
                                                print("Removing Active Day: \(day.rawValue)")
                                                newHabit.removeActiveDay(day: day)
                                            }
                                    } else {
                                        Text(String(day.rawValue.first!))
                                            .fontWeight(.black)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Circle()
                                                    .fill(newHabit.accent.mainColor.tertiary)
                                                    .frame(width: 35, height: 35)
                                            )
                                            .onTapGesture {
                                                print("Adding Active Day: \(day.rawValue)")
                                                newHabit.addActiveDay(day: day)
                                            }
                                    }
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                        }
                    }
                    
                    // End Date for habits
                    Toggle("End Habit At Date?", isOn: $newHabit.hasEndDate)
                    if (newHabit.hasEndDate) {
                        // set when to recieve notifications for this habit
                        DatePicker("End on ", selection: $newHabit.endDate)
                            .datePickerStyle(.compact)
                    }
                }
                
                // Notifications Section
                Section(header: Text("Notifications")) {
                    Toggle("Recieve Notifications", isOn: $newHabit.notifications)
                        .onChange(of: newHabit.notifications) { value in
//                            newHabit.notificationMessage =  TODO: Implement changing notifications method here and in notification manager
                        }
                    if (newHabit.notifications) {
                        // set when to recieve notifications for this habit
                        DatePicker("Time", selection: $newHabit.notificationTime)
                            .datePickerStyle(.compact)
                    }
                }
            }
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button() {
                        isPresentingNewHabitView = false
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        habits.append(newHabit)
                        if (newHabit.notifications) {
                            NotificationManager.instance.scheduleNotification(for: newHabit)
                        }
                        isPresentingNewHabitView = false
                    }
                }
            }
            .accentColor(appData.account.accentTheme.standardColor)
        }
        .alert(isPresented: $isShowingHelpAlert) {
            Alert(title: Text("\(alertTitle)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Got it!")))
        }
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(habits: .constant(Habit.testHabits),
                     isPresentingNewHabitView: .constant(true))
        .environmentObject(AppData())
    }
}

extension HorizontalAlignment {
    private enum ControlAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[HorizontalAlignment.center]
        }
    }
    static let controlAlignment = HorizontalAlignment(ControlAlignment.self)
}
