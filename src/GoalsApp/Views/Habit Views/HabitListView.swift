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
    
    // show \ hide bools for list sections
    @State private var showDailyHabits = true
    @State private var showWeeklyHabits = true
    @State private var showMonthlyHabits = true
    @State private var showSkippedHabits = true
    
    // SORTING OPTIONS // TODO: IMPLEMENT THIS
    enum SortOption {
        case dueDate, dateCreated, priority
    }
    @State private var sortOption: SortOption = .priority

    
    var body: some View {
        
        ZStack {
            NavigationStack {
                List {
                    if habits.contains(where: { $0.frequency == .daily }) {
                        Section (
                            header: 
                                HStack {
                                Text ("TODAY")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                    .monospaced()
                                Spacer()
                                    Button {
                                        withAnimation {
                                            showDailyHabits.toggle()
                                        }
                                    } label: {
                                        Label("", systemImage: "chevron.right")
                                            .labelStyle(.iconOnly)
                                            .tint(appData.account.accentTheme.mainColor)
                                            .imageScale(.large)
                                            .rotationEffect(.degrees(showDailyHabits ? 90 : 0))
                                            .animation(.easeInOut, value: showDailyHabits)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 25)
                                .listRowBackground(appData.account.backgroundTheme.mainColor)
                                .listRowSeparator(.hidden)) {
                                    if showDailyHabits {
                                        ForEach($habits) { $habit in
                                            if habit.frequency == .daily && !habit.isSkipped{
                                                HStack {
                                                    Spacer()
                                                    HabitCardView(habit: $habit)
                                                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                                        .opacity(habit != selectedHabit ? 1: 0)
                                                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                                                        .matchedGeometryEffect(id: habit.id, in: namespace, properties: .frame, anchor: .top, isSource: habit != selectedHabit)
                                                    Spacer()
                                                }
                                                .highPriorityGesture(TapGesture(count: 1).onEnded {
                                                    withAnimation (.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 10)) {
                                                        selectedHabit = habit
                                                    }
                                                    print("Selected \(habit.title) habit for details: ")
                                                })
                                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                    Button() {
                                                        print("Skipping \(habit.title) habit for current cycle")
                                                        habit.toggleSkipped()
                                                    } label: {
                                                        Label("SKIP", systemImage: "moon.zzz.fill")
                                                    }
                                                    .tint(.purple)
                                                }
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
                                        }
                                        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    .listRowBackground(appData.account.backgroundTheme.mainColor)
                                    }
                                } // Daily Section
                    } // Daily Section
                    
                    
                    if habits.contains(where: { $0.frequency == .weekly }) {
                        Section (
                            header: HStack {
                                Text ("THIS WEEK")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                    .monospaced()
                                Spacer()
                                    Button {
                                        withAnimation {
                                            showWeeklyHabits.toggle()
                                        }
                                    } label: {
                                        Label("", systemImage: "chevron.right")
                                            .labelStyle(.iconOnly)
                                            .tint(appData.account.accentTheme.mainColor)
                                            .imageScale(.large)
                                            .rotationEffect(.degrees(showWeeklyHabits ? 90 : 0))
                                            .animation(.easeInOut, value: showWeeklyHabits)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 25)
                                .listRowBackground(appData.account.backgroundTheme.mainColor)
                                .listRowSeparator(.hidden)) {
                                    if showWeeklyHabits {
                                        ForEach($habits) { $habit in
                                            if habit.frequency == .weekly && !habit.isSkipped {
                                                HStack {
                                                    Spacer()
                                                    HabitCardView(habit: $habit)
                                                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                                        .opacity(habit != selectedHabit ? 1: 0)
                                                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                                                        .matchedGeometryEffect(id: habit.id, in: namespace, properties: .frame, anchor: .top, isSource: habit != selectedHabit)
                                                    Spacer()
                                                }
                                                .highPriorityGesture(TapGesture(count: 1).onEnded {
                                                    withAnimation (.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 10)) {
                                                        selectedHabit = habit
                                                    }
                                                    print("Selected \(habit.title) habit for details: ")
                                                })
                                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                    Button() {
                                                        print("Skipping \(habit.title) habit for current cycle")
                                                        habit.toggleSkipped()
                                                    } label: {
                                                        Label("SKIP", systemImage: "moon.zzz.fill")
                                                    }
                                                    .tint(.purple)
                                                }
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
                                        }
                                        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    .listRowBackground(appData.account.backgroundTheme.mainColor)
                                    }
                            }
                    } // Weekly Section
                    
                    if habits.contains(where: { $0.frequency == .monthly }) {
                        Section (
                            header: HStack {
                                Text ("THIS MONTH")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                    .monospaced()
                                Spacer()
                                    Button {
                                        withAnimation {
                                            showMonthlyHabits.toggle()
                                        }
                                    } label: {
                                        Label("", systemImage: "chevron.right")
                                            .labelStyle(.iconOnly)
                                            .tint(appData.account.accentTheme.mainColor)
                                            .imageScale(.large)
                                            .rotationEffect(.degrees(showMonthlyHabits ? 90 : 0))
                                            .animation(.easeInOut, value: showMonthlyHabits)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 25)
                                .listRowBackground(appData.account.backgroundTheme.mainColor)
                                .listRowSeparator(.hidden)) {
                                    if showMonthlyHabits {
                                        ForEach($habits) { $habit in
                                            if habit.frequency == .monthly && !habit.isSkipped {
                                                HStack {
                                                    Spacer()
                                                    HabitCardView(habit: $habit)
                                                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                                        .opacity(habit != selectedHabit ? 1: 0)
                                                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                                                        .matchedGeometryEffect(id: habit.id, in: namespace, properties: .frame, anchor: .top, isSource: habit != selectedHabit)
                                                    Spacer()
                                                }
                                                .highPriorityGesture(TapGesture(count: 1).onEnded {
                                                    withAnimation (.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 10)) {
                                                        selectedHabit = habit
                                                    }
                                                    print("Selected \(habit.title) habit for details: ")
                                                })
                                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                    Button() {
                                                        print("Skipping \(habit.title) habit for current cycle")
                                                        habit.toggleSkipped()
                                                    } label: {
                                                        Label("SKIP", systemImage: "moon.zzz.fill")
                                                    }
                                                    .tint(.purple)
                                                }
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
                                        }
                                        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                        
                                        .listRowSeparator(.hidden)
                                    .listRowBackground(appData.account.backgroundTheme.mainColor)
                                    }
                            }
                    } // Monthly Section
                    
                    if habits.contains(where: { $0.isSkipped }) {
                        Section (
                            header: HStack {
                                Text ("SKIPPED")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                    .monospaced()
                                Spacer()
                                    Button {
                                        withAnimation {
                                            showSkippedHabits.toggle()
                                        }
                                    } label: {
                                        Label("", systemImage: "chevron.right")
                                            .labelStyle(.iconOnly)
                                            .tint(appData.account.accentTheme.mainColor)
                                            .imageScale(.large)
                                            .rotationEffect(.degrees(showSkippedHabits ? 90 : 0))
                                            .animation(.easeInOut, value: showSkippedHabits)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 25)
                                .listRowBackground(appData.account.backgroundTheme.mainColor)
                                .listRowSeparator(.hidden)) {
                                    if showSkippedHabits {
                                        ForEach($habits) { $habit in
                                            if habit.isSkipped {
                                                HStack {
                                                    Spacer()
                                                    HabitCardView(habit: $habit)
                                                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                                        .opacity(habit != selectedHabit ? 1: 0)
                                                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                                                        .matchedGeometryEffect(id: habit.id, in: namespace, properties: .frame, anchor: .top, isSource: habit != selectedHabit)
                                                    Spacer()
                                                }
                                                .highPriorityGesture(TapGesture(count: 1).onEnded {
                                                    withAnimation (.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 10)) {
                                                        selectedHabit = habit
                                                    }
                                                    print("Selected \(habit.title) habit for details: ")
                                                })
                                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                    Button() {
                                                        print("Skipping \(habit.title) habit for current cycle")
                                                        habit.toggleSkipped()
                                                    } label: {
                                                        Label("SKIP", systemImage: "moon.zzz.fill")
                                                    }
                                                    .tint(.purple)
                                                }
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
                                        }
                                        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    .listRowBackground(appData.account.backgroundTheme.mainColor)
                                    }
                            }
                    } // Skipped Section
                    
                } // END OF LIST
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
                                .font(.title2)
                        }
                        .accessibilityLabel("Settings")
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        VStack {
                            Text("Habits")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .padding(.leading, 5)
                                .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                        }
                    }
                }
                .foregroundStyle(appData.account.accentTheme.mainColor)
            }
            .sheet(isPresented: $isPresentingAccountView) {
                AccountSettingsView(isPresentingAccountView: $isPresentingAccountView)
                    .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
            }
            
            if selectedHabit != nil {
                HabitDetailView(selectedHabit: selectedHabit, namespace: namespace)
                    .padding(.top, 50)
                    .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                
                    .onTapGesture {
                        withAnimation (.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.2)) {
                            selectedHabit = nil
                        }
                    }
            }
        }
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
        
    }
}

#Preview {
    HabitListView(habits: .constant(Habit.testHabits))
        .environmentObject(AppData())
}
