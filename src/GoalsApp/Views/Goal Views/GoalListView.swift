//
//  GoalListView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import SwiftUI

struct GoalListView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var goals: [Goal]
    @State private var isPresentingAccountView = false
    @State private var isPresentingNewGoalView = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($goals) { $goal in
//                    NavigationLink(destination: GoalDetailView(goal: $goal)) {
//                        GoalCardView(goal: goal)
                    }
//                    .listRowBackground(goal.theme.mainColor)
                }
//                .onDelete(perform: delete)
            }
            .navigationTitle("Goals")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresentingAccountView = true
                    }) {
                        Image(systemName: "person.circle")
                    }
                    .accessibilityLabel("Account")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingNewGoalView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Goal")
                }
            }
            .foregroundStyle(appData.account.accentTheme.mainColor)
        }
//        .sheet(isPresented: $isPresentingAccountView) {
//            AccountView(isPresentingAccountView: $isPresentingAccountView)
//                .accentColor(appData.account.accentTheme.mainColor)
//        }
//        .sheet(isPresented: $isPresentingNewGoalView) {
//            NewGoalView(goals: $goals, isPresentingNewGoalView: $isPresentingNewGoalView)
//                .accentColor(appData.account.accentTheme.mainColor)
//        }
        
//    }
    
//    func delete(at offsets: IndexSet) {
//        goals.remove(atOffsets: offsets)
//    }
    
}

struct GoalsList_Previews: PreviewProvider {
    static var previews: some View {
        GoalListView(goals: .constant(Goal.testGoals))
            .environmentObject(AppData())
        
    }
}
