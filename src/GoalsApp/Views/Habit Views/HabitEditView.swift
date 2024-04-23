//
//  HabitEditView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 4/13/24.
//

import SwiftUI

struct HabitEditView: View {
    @EnvironmentObject var appData: AppData
    @Binding var isPresentingHabitEditView: Bool
    @Binding var selectedHabit: Habit
    
    @State private var isPresentingIconView = false

    
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
                            Image(systemName: selectedHabit.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .foregroundColor(selectedHabit.accent.standardColor)
                                .sheet(isPresented: $isPresentingIconView, content: {
                                    IconPickerView(selection: $selectedHabit.icon, title: "Choose your symbol", autoDismiss: true)
                                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                }).padding()
                        }
                        Spacer()
                    }
                    AccentPickerView(newHabit: $selectedHabit)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                    
                    //Habit Theme Picker
                    NavigationLink(destination: ThemePickerView(selection: $selectedHabit.theme).preferredColorScheme(appData.account.backgroundTheme.colorScheme)) {
                        HStack {
                            Text("Theme:")
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedHabit.theme.mainColor)
                                .frame(width: 200, height: 30)
                                .overlay(
                                    Text(selectedHabit.theme.name)
                                        .font(.headline)
                                        .foregroundStyle(selectedHabit.theme.complementaryColor)
                                )
                            Spacer()
                        }
                    }
                }
                
                //General Info Section
                Section(header:
                        Text("Habit Info")
                ) {
                    TextField("Title:", text: $selectedHabit.title)
                    TextField("Description:", text: $selectedHabit.content)
                    
                    Picker("Unit Name:", selection: $selectedHabit.unitName) {
                        ForEach(Habit.Units.allCases, id: \.self) {unit in
                            if unit == .none {
                                Text("None").tag(unit.rawValue)
                            } else {
                                Text(unit.rawValue.capitalized).tag(unit.rawValue)
                            }
                        }
                    }
                    
                    // priority selector
                    Picker("Priority: \(selectedHabit.priority.rawValue)", selection: $selectedHabit.priority) {
                        ForEach(Habit.Priority.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } // END of Info Section
                
            }
            
            .navigationTitle("Edit Habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresentingHabitEditView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        isPresentingHabitEditView = false
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    HabitEditView(isPresentingHabitEditView: .constant(true), selectedHabit: .constant(Habit.testHabits[0]))
        .environmentObject(AppData())
}
