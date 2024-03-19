//
//  Habit.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var content: String
    var icon: String = "star"
    var theme: HabitTheme
    var streak: Int = 0
    enum Frequency: String, Codable, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
    var frequency: Frequency
    var dueDate: Date = Date()
    var goalAmount: Int = 1
    var currentAmount: Int = 0
    var isComplete: Bool = false
    // stat tracking
    var accent: Accent = .auto
    var dateCreated: Date = Date()
    var datesCompleted: [Date] = []
    var notifications: Bool = false
    var notificationTime: Date = Date()
    
    init(id: UUID = UUID(), title: String, content: String, theme: HabitTheme, streak: Int, frequency: Frequency) {
        self.id = id
        self.title = title
        self.content = content
        self.theme = theme
        self.streak = streak
        self.frequency = frequency
    }
    
    static var emptyHabit: Habit {
        Habit(title: "", content: "", theme: .organicBlue, streak: 0, frequency: .daily)
    }
    
    // Mark habit as complete
    mutating func markComplete() {
        isComplete = true
        currentAmount = goalAmount
        datesCompleted.append(Date())
        streak += 1
    }
    
    // Mark habit as incomplete
    mutating func markIncomplete() {
        isComplete = false
        currentAmount = 0
        datesCompleted.removeLast()
        streak -= 1
    }
    
    // once due date passes and habit is not complete reset streak
    mutating func missed() {
        streak = 0
        isComplete = false
        currentAmount = 0
        if Frequency.daily == frequency {
            dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        } else if Frequency.weekly == frequency {
            dueDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
        } else if Frequency.monthly == frequency {
            dueDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
        }
        
    }
    
    // once due date is hit and habit is complete reset the due date
    mutating func hit() {
        isComplete = false
        currentAmount = 0
        if Frequency.daily == frequency {
            dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        } else if Frequency.weekly == frequency {
            dueDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
        } else if Frequency.monthly == frequency {
            dueDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
        }
    }
    
    // update the habit to check if it hits or misses on its due date
    mutating func update() {
        if Date() >= dueDate {
            if isComplete {
                hit()
                print("\(title) hit")
            } else {
                missed()
                print("\(title) missed")
            }
        }
    }
    
}

extension Habit {
    static let testHabits: [Habit] =
    [
        Habit(
            title: "Water plants",
            content: "",
            theme: .organicGreen,
            streak: 3,
            frequency: .weekly
            
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
            content: "",
            theme: .organicBlue,
            streak: 9,
            frequency: .monthly
        )
    ]
}
