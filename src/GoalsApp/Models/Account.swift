//
//  Account.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

struct Account: Identifiable, Codable {
    var id = UUID()
    var accentTheme: Accent
    var backgroundTheme: BackgroundTheme
    var notificationsEnabled: Bool = true
    
    
    // HABITS
    var habits: [Habit] = [] // all Habits list
    
    var dailyHabits: [Habit] {
        habits.filter { $0.frequency == .daily }
    }
    var weeklyHabits: [Habit] {
        habits.filter { $0.frequency == .weekly }
    }
    var monthlyHabits: [Habit] {
        habits.filter { $0.frequency == .monthly }
    }
    var skippedHabits: [Habit] {
        habits.filter { $0.isSkipped }
    }
    
    // STAT TRACKING
    var acctBestStreak: Int {
        habits.map { $0.highestStreak }.max() ?? 0
    }
    var acctAllTimeCompletionRate: Double {
        let totalAttempts = habits.map { $0.globalHabitTotalAttempts }.reduce(0, +)
        let totalCompleted = habits.map { $0.totalCompleted }.reduce(0, +)
        return Double(totalCompleted) / Double(totalAttempts)
    }
    var acctTotalCompletions: Int {
        habits.map { $0.totalCompleted }.reduce(0, +)
    }
    
    
    var activeHabitsComplete: Int { // number of habits that are completed for the period
        return habits.filter { $0.isComplete && !$0.isSkipped}.count
    }
    var activeHabitsIncomplete: Int { // number of habits that are incomplete for the period
        return habits.filter { !$0.isComplete && !$0.isSkipped}.count
    }
    var activeHabitsSkipped: Int { // number of habits that are skipped for the period
        return habits.filter { $0.isSkipped }.count
    }
    var activeHabitThemes: [HabitTheme] {
        habits.map { $0.theme }
    }
    
    
    // INIT
    init() {
        accentTheme = .Light
        backgroundTheme = .Dark
    }
    
    init(accentTheme: Accent, backgroundTheme: BackgroundTheme) {
        self.accentTheme = accentTheme
        self.backgroundTheme = backgroundTheme
    }
}
