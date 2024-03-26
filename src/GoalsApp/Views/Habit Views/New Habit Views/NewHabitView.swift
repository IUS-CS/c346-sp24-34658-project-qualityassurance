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
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Habit Icon")){
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresentingIconView.toggle()
                        }) {
                            Image(systemName: newHabit.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .foregroundColor(newHabit.accent.mainColor)
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
                    ThemePickerView(selection: $newHabit.theme)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                }
                Section(header: Text("Habit Info")) {
                    TextField("Title", text: $newHabit.title)
                    TextField("Description", text: $newHabit.content)
                }
                Section(header: Text("Habit Frequency and Amounts")) {
                    Picker("Frequency", selection: $newHabit.frequency) {
                        ForEach(Habit.Frequency.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Stepper(value: $newHabit.goalAmount, in: 1...10000, step: 1) {
                        Text("Goal Amount: \(newHabit.goalAmount)")
                    }
                }
                .listRowSeparator(.hidden)
                
                Section(header: Text("Date")) {
                    DatePicker("Due Date:", selection: $newHabit.dueDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Recieve Notifications", isOn: $newHabit.notifications)
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
            .accentColor(appData.account.accentTheme.mainColor)
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
