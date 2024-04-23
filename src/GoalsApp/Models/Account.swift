//
//  Account.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

/// A model representing a users account.
/// It stores various user settings and data like notifications, sounds, and the list of habits associated with the account.
struct Account: Identifiable, Codable {
    /// Unique identifier for the account.
    var id = UUID()

    /// The accent theme for the account's visual styling.
    var accentTheme: Accent

    /// The background theme for the account's visual styling.
    var backgroundTheme: BackgroundTheme
    
    // MARK: - User Changeable Settings
    
    /// Indicates whether notifications are enabled for the account.
    var notificationsEnabled: Bool = true
    
    /// Indicates whether completed habits should be displayed.
    var showCompletedHabits: Bool = true
    
    /// Indicates whether celebrations are enabled for achieving goals.
    var celebrationsEnabled: Bool = true
    
    /// Indicates whether haptic feedback is enabled for user interactions.
    var hapticFeedbackEnabled: Bool = true
    
    /// Indicates whether sound effects are enabled for notifications, selections, completions, and failures.
    var soundsEnabled: Bool = true
    
    // MARK: - Sounds
    
    /// The sound to be played for notifications.
    var notificationSound: Sound = .Ping
    
    /// The sound to be played for selections.
    var selectionSound: Sound = .Pop
    
    /// The sound to be played for habit completions.
    var completionSound: Sound = .Hero
    
    /// The sound to be played for habit failures.
    var failureSound: Sound = .Bottle
    
    // MARK: - Habits
    
    /// The list of all habits associated with the account.
    var habits: [Habit] = [] // All Habits list
    
    /// Retrieves the list of daily habits.
    var dailyHabits: [Habit] {
        habits.filter { $0.frequency == .daily }
    }
    
    /// Retrieves the list of weekly habits.
    var weeklyHabits: [Habit] {
        habits.filter { $0.frequency == .weekly }
    }
    
    /// Retrieves the list of monthly habits.
    var monthlyHabits: [Habit] {
        habits.filter { $0.frequency == .monthly }
    }
    
    /// Retrieves the list of skipped habits.
    var skippedHabits: [Habit] {
        habits.filter { $0.isSkipped }
    }
    
    // MARK: - Functions
    
    /// Deletes a given habit from the list of habits.
    /// - Parameter habit: The habit to be deleted.
    mutating func deleteHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
    }
    
    /// Updates the list of habits, checking for their end dates and updating them based on their due dates.
    mutating func updateHabits() {
        habits = habits.map { habit in
            var habit = habit
            if habit.hasEndDate && Date() >= habit.endDate {
                deleteHabit(habit)
            } else {
                habit.update()
            }
            return habit
        }
    }
    
    // MARK: - Statistical Tracking
    
    /// Calculates the daily completion rate for all habits.
    var dailyCompletionRate: Double {
        let totalHabits = habits.count
        let totalCompleted = habits.map { $0.periodCompletionRate }.reduce(0, +)
        return Double(totalCompleted) / Double(totalHabits)
    }
    
    /// Retrieves the best streak across all habits in the account.
    var acctBestStreak: Int {
        habits.map { $0.highestStreak }.max() ?? 0
    }
    
    /// Calculates the all-time completion rate for all habits.
    var acctAllTimeCompletionRate: Double {
        let totalAttempts = habits.map { $0.habitTotalAttempts }.reduce(0, +)
        let totalCompleted = habits.map { $0.totalCompleted }.reduce(0, +)
        return Double(totalCompleted) / Double(totalAttempts)
    }
    
    /// Calculates the total number of completions across all habits in the account.
    var acctTotalCompletions: Int {
        habits.map { $0.totalCompleted }.reduce(0, +)
    }
    
    /// Retrieves the number of habits that are completed for the current period.
    var activeHabitsComplete: Int {
        return habits.filter { $0.isComplete && !$0.isSkipped}.count
    }
    
    /// Retrieves the number of habits that are incomplete for the current period.
    var activeHabitsIncomplete: Int {
        return habits.filter { !$0.isComplete && !$0.isSkipped}.count
    }
    
    /// Retrieves the number of habits that are skipped for the current period.
    var activeHabitsSkipped: Int {
        return habits.filter { $0.isSkipped }.count
    }
    
    /// Retrieves a list of themes for all active habits.
    var activeHabitThemes: [HabitTheme] {
        habits.map { $0.theme }
    }
    
    // MARK: - Initializers
    
    /// Initializes a new Account with default settings for accent and background themes.
    init() {
        accentTheme = .Light
        backgroundTheme = .Dark
    }
    
    /// Initializes a new Account with specific settings for accent and background themes.
    /// - Parameters:
    ///   - accentTheme: The accent theme for the account.
    ///   - backgroundTheme: The background theme for the account.
    init(accentTheme: Accent, backgroundTheme: BackgroundTheme) {
        self.accentTheme = accentTheme
        self.backgroundTheme = backgroundTheme
    }
}
