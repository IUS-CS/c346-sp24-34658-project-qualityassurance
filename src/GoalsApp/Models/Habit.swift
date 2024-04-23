//
//  Habit.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

/// A model representing a habit that a user wants to track in a habit-tracking app.
struct Habit: Identifiable, Codable, Equatable {
    /// Unique identifier for the habit.
    var id = UUID()

    /// The title or name of the habit.
    var title: String

    /// A description or content related to the habit.
    var content: String

    /// An icon representing the habit.
    var icon: String = "bookmark.fill"

    /// The visual theme for the habit.
    var theme: HabitTheme

    /// The current streak for the habit, representing consecutive completions.
    var streak: Int = 0

    /// Indicates if the habit is currently active or not.
    var toDo: Bool = true

    /// Enum representing the priority level of the habit.
    enum Priority: String, Codable, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }
    var priority: Priority = .medium

    /// Enum representing the frequency with which the habit should be completed.
    enum Frequency: String, Codable, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
    var frequency: Frequency

    /// Enum representing the days of the week.
    enum Days: String, Codable, CaseIterable {
        case Sunday = "Sunday", Monday = "Monday", Tuesday = "Tuesday", Wednesday = "Wednesday", Thursday = "Thursday", Friday = "Friday", Saturday = "Saturday"
    }

    /// The days on which the habit is active.
    var activeDays: [Days] = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday]
    
    /// The days on which the habit is inactive
    var inactiveDays: [Days] = []

    /// Indicates whether the habit has an end date.
    var hasEndDate: Bool = false // TODO: Implement

    /// The end date for the habit, after which it is no longer tracked.
    var endDate: Date = Date().endOfMonth // TODO: Implement

    /// Defines the current period (start and end dates) based on the habit's frequency.
    var period: (start: Date, end: Date) {
        switch frequency {
        case .daily:
            let startOfDay = Calendar.current.startOfDay(for: Date())
            return (startOfDay, startOfDay.endOfDay)
        case .weekly:
            let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            let endOfWeek = Calendar.current.date(byAdding: DateComponents(day: -1, weekOfMonth: 1), to: startOfWeek)!

            return (startOfWeek, endOfWeek)
        case .monthly:
            let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
            let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
            return (startOfMonth, endOfMonth.startOfDay)
        }
    }
    
    /// The due date for the habit's current period.
    var dueDate: Date = Date().endOfDay


    /// The current amount achieved for the habit during its current period.
    var currentAmount: Int = 0

    /// The goal amount to be achieved for the habit during its current period.
    var goalAmount: Int = 1

    /// Enum representing the units used to measure the habit's progress.
    enum Units: String, Codable, CaseIterable {
        case none = ""
        case count = "count"
        case steps = "steps"
        case drinks = "drinks"
        case reps = "reps"
        case mins = "mins"
        case hrs = "hrs"
        case days = "days"
        case oz = "oz"
        case miles = "miles"
        case km = "km"
        case lbs = "lbs"
    }
    
    /// The unit name used to measure the habit's progress.
    var unitName: String = ""

    /// Indicates whether the habit is complete.
    var isComplete: Bool = false
    
    /// Indicates whether the habit is skipped (no negative effects).
    var isSkipped: Bool = false

    /// A custom message for notifications related to the habit.
    var notificationMessage: String = ""

    // MARK: - Stat Tracking
    
    /// The accent color for the habit.
    var accent: Accent = .accentRed

    /// Dates on which the habit was completed.
    var datesCompleted: [Date] = []
    
    /// A dictionary storing the dates and completion amounts for missed days.
    var missedDays_andAmount: [Date: Int] = [:]
    
    /// Dates on which the habit was skipped.
    var skippedDays: [Date] = []

    /// The completion rate for the current period of the habit.
    var periodCompletionRate: Double = 0

    /// The date the habit was created.
    var dateCreated: Date = Date()

    /// Indicates whether notifications are enabled for the habit.
    var notifications: Bool = false

    /// The time at which notifications for the habit are scheduled.
    var notificationTime: Date = Date()

    /// The highest streak for the habit.
    var highestStreak: Int = 0
    
    /// The total number of completions for the habit.
    var totalCompleted: Int = 0
    
    /// The total number of times the habit was missed.
    var totalMissed: Int = 0
    
    /// The total number of times the habit was skipped.
    var totalSkipped: Int = 0
    
    /// The total attempts made at the habit.
    var habitTotalAttempts: Int = 0
    
    /// The total percentage of the habit completed.
    var habitTotalPercentageCompleted: Double = 0
    
    /// The total percentage of the habit missed.
    var habitTotalPercentageMissed: Double = 0
    
    /// An unused property for a celebration function.
    var celebration: Int = 0

    // MARK: - Static Properties
    
    /// Returns an empty habit with default properties.
    static var emptyHabit: Habit {
        Habit(title: "", content: "", theme: .organicBlue, streak: 0, frequency: .daily)
    }
    
    /// Provides a list of test habits for demonstration or testing purposes.
    static let testHabits: [Habit] = [
        Habit(
            title: "Water plants",
            content: "Monstera, Snake Plant, Venus Fly Trap, and the Cactus.",
            theme: .organicGreen,
            streak: 3,
            frequency: .daily
        ),
        Habit(
            title: "Practice Basketball",
            content: "",
            theme: .organicRed,
            streak: 6,
            frequency: .weekly
        ),
        Habit(
            title: "Clean the house",
            content: "Dishes, Laundry, and the Floors.",
            theme: .organicBlue,
            streak: 9,
            frequency: .monthly
        )
    ]
    
    // MARK: - Functions
    
    /// Removes a given day from the list of active days
    /// - Parameter day: The day to remove
    mutating func removeActiveDay(day: Days) {
        if activeDays.contains(day) {
            activeDays.remove(at: activeDays.firstIndex(of: day)!)
            inactiveDays.append(day)
        }
    }
    
    /// Adds a given day to the list of active days
    /// - Parameter day: The day to add
    mutating func addActiveDay(day: Days) {
        if !activeDays.contains(day) {
            activeDays.append(day)
            inactiveDays.remove(at: inactiveDays.firstIndex(of: day)!)
        }
    }
    
    /// Updates the global total percentage of completed and missed for this habit
    mutating func updateCompletionPercentage() {
        if habitTotalAttempts == 0 {
            habitTotalPercentageCompleted = 0
            habitTotalPercentageMissed = 0
        } else {
            habitTotalPercentageCompleted = Double(totalCompleted) / Double(habitTotalAttempts)
            habitTotalPercentageMissed = Double(totalMissed) / Double(habitTotalAttempts)
        }
    }
    
    /// Toggles the habit's skipped state
    mutating func toggleSkipped() {
        isSkipped.toggle()
        if isSkipped {
            totalSkipped += 1
        } else {
            totalSkipped -= 1
        }
    }
    
    /// Marks the habit as complete
    mutating func markComplete() {
        isComplete = true
        currentAmount = goalAmount
        periodCompletionRate = Double(currentAmount) / Double(goalAmount)
        datesCompleted.append(Date().startOfDay)
        streak += 1
    }
    
    /// Marks the habit as incomplete
    mutating func markIncomplete() {
        if isSkipped {
            isSkipped = false
        }
        periodCompletionRate = Double(currentAmount) / Double(goalAmount)
        isComplete = false
        datesCompleted.removeLast()
        streak -= 1
    }
    
    /// Handles the event when a habit is missed
        /// - Updates the streak, total missed, and sets the due date for the next habit period
    mutating func missed() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date().startOfDay)!
        if !isSkipped {
            // If habit isnt skipped
            streak = 0
            isComplete = false
            totalMissed += 1
            habitTotalAttempts += 1
            // add to missed days amount
            missedDays_andAmount[yesterday] = (currentAmount/goalAmount)
            currentAmount = 0
        } else {
            // If habit is skipped when due date is hit
            skippedDays.append(yesterday)
        }
        if Frequency.daily == frequency {
            dueDate = dueDate.addingTimeInterval(86400).endOfDay
        } else if Frequency.weekly == frequency {
            dueDate = dueDate.addingTimeInterval(604800).endOfDay
        } else if Frequency.monthly == frequency {
            dueDate = dueDate.addingTimeInterval(2592000).endOfDay
        }
        isSkipped = false
        updateCompletionPercentage()
    }
    
    /// Handles the event when a habit is completed (hit)
       /// - Updates total completed, streak, and sets the due date for the next habit period
    mutating func hit() {
        isComplete = false
        currentAmount = 0
        totalCompleted += 1
        habitTotalAttempts += 1
        if streak > highestStreak {
            highestStreak = streak
        }
        
        if Frequency.daily == frequency {
            dueDate = dueDate.addingTimeInterval(86400).endOfDay
            // If due date falls on an exempt day add another day
            for day in inactiveDays {
                if dueDate.formatted(.dateTime.weekday(.wide)) == day.rawValue {
                    dueDate = dueDate.addingTimeInterval(86400).endOfDay
                }
            }
        } else if Frequency.weekly == frequency {
            dueDate = dueDate.addingTimeInterval(604800).endOfDay
        } else if Frequency.monthly == frequency {
            dueDate = dueDate.addingTimeInterval(2592000).endOfDay
        }
        isSkipped = false
        updateCompletionPercentage()
    }
    
    /// Checks and updates the habit based on due dates
    mutating func update() {
        if Date() >= dueDate {
            if isComplete {
                periodCompletionRate = Double(currentAmount) / Double(goalAmount)
                print("\(title) hit")
                hit()
            } else {
                periodCompletionRate = Double(currentAmount) / Double(goalAmount)
                print("\(title) missed")
                missed()
            }
        } else {
            print("\(title) is not due yet")
        }
    }
    
    // MARK: - Initializers
    
    /// Initializes a new habit with given parameters
    /// - Parameters:
    ///   - id: Unique identifier (defaults to a new UUID)
    ///   - title: Title of the habit
    ///   - content: Description of the habit
    ///   - theme: Background color of the habit
    ///   - streak: The current streak (consecutive completions)
    ///   - frequency: Enum defining how often the habit should be completed
    init(id: UUID = UUID(), title: String, content: String, theme: HabitTheme, streak: Int, frequency: Frequency) {
        self.id = id
        self.title = title
        self.content = content
        self.theme = theme
        self.streak = streak
        self.frequency = frequency
    }

}
