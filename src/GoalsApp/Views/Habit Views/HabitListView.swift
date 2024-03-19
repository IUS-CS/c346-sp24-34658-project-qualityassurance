//
//  HabitListView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import SwiftUI

struct HabitListView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var habits: [Habit]
    @State private var isPresentingAccountView = false
    
    @State private var selectedHabit: Habit?
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    Section {
                        ForEach($habits) { $habit in
                            Button {
//                                withAnimation (.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 10)) {
//                                    selectedHabit = habit
//                                }
//                                print("Selected Habit for details: \(habit.title)")
                            } label: {
                                HStack {
                                    Spacer()
                                    HabitCardView(habit: $habit)
                                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                                        .matchedGeometryEffect(id: habit.id, in: namespace, properties: .frame, anchor: .top, isSource: habit != selectedHabit)
                                    Spacer()
                                }
                            }
                            .highPriorityGesture(TapGesture(count: 1).onEnded {
                                withAnimation (.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 10)) {
                                    selectedHabit = habit
                                }
                                print("Selected Habit for details: \(habit.title)")
                            })
                            .swipeActions() {
                                Button(role: .destructive) {
                                    print("Delete")
                                    habits.remove(at: habits.firstIndex(of: habit)!)
                                }
                            label: {
                                Label("Delete", systemImage: "trash")
                            }
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(appData.account.backgroundTheme.mainColor)
                    }
                }
                .refreshable {
                    print("Refreshing...")
                    if (habits.count > 0) {
                        for (index, _) in habits.enumerated() {
                            habits[index].update()
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
                .background(appData.account.backgroundTheme.mainColor)
                
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            isPresentingAccountView = true
                        }) {
                            Image(systemName: "gearshape.fill")
                        }
                        .accessibilityLabel("Settings")
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        VStack {
                            Text("Today")
                                .font(.largeTitle)
                                .padding(.leading, 10)
                                .fontWeight(.black)
                                .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                        }
                    }
                }
                .foregroundStyle(appData.account.accentTheme.mainColor)
            }
            .sheet(isPresented: $isPresentingAccountView) {
                AccountSettingsView(isPresentingAccountView: $isPresentingAccountView)
                    .preferredColorScheme(appData.account.backgroundTheme.complementaryColor == .white ? .dark : .light)
            }
            
            if selectedHabit != nil {
                HabitDetailView(selectedHabit: selectedHabit, namespace: namespace)
                    .onTapGesture {
                        withAnimation (.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2)) {
                            selectedHabit = nil
                        }
                    }
            }
        }
        
    }
}

#Preview {
    HabitListView(habits: .constant(Habit.testHabits))
        .environmentObject(AppData())
}
