//
//  Habit.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Codable, Equatable { // TODO: SEE ABOUT MAKING THIS COMPARABLE FOR SORTING PURPOSES
    
    var id = UUID()
    var title: String
    var content: String
    var icon: String = "bookmark.fill"
    var theme: HabitTheme
    var streak: Int = 0
    var priority: Int           // 0 = low, 1 = medium, 2 = high TODO: CHANGE THIS TO BE MORE INTERESTING OF A SCALE FOR USERS
    enum Frequency: String, Codable, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
    var frequency: Frequency
    var dueDate: Date = Date().endOfDay
    var currentAmount: Int = 0
    var goalAmount: Int = 1
    var isComplete: Bool = false
    var isSkipped: Bool = false // If skipped no negative effects will come from missing the habit
    
    // stat tracking
    var celebration: Int = 0
    var accent: Accent = .Light
    var dateCreated: Date = Date()
    var datesCompleted: [Date] = []
    var notifications: Bool = false
    var notificationTime: Date = Date()
    var highestStreak: Int = 0
    var totalCompleted: Int = 0
    var totalMissed: Int = 0
    var totalSkipped: Int = 0
    var missedDaysAmount: [Date: Int] = [:] // stores the date the habit failed with the percentage that was completed that day
    var globalHabitTotalAttempts: Int = 0 // the total of all the times this habit was tried (total missed + totalcompleted)
    var globalTotalPercentageCompleted: Double = 0 // the total percentage of the habit completed out of the total amount of times tried
    var globalTotalPercentageMissed: Double = 0  // the total percentage of the habit missed out of the total amount of times tried
    
    // TODO: STORE THE LAST 12 MONTHS TOTAL PERCENTAGE OF COMPLETED HABITS OUT OF POSSIBLE HABITS IN A DICTIONARY
    
    init(id: UUID = UUID(), title: String, content: String, theme: HabitTheme, streak: Int, frequency: Frequency, priority: Int) {
        self.id = id
        self.title = title
        self.content = content
        self.theme = theme
        self.streak = streak
        self.frequency = frequency
        self.priority = priority
    }
    
    static var emptyHabit: Habit {
        Habit(title: "", content: "", theme: .organicBlue, streak: 0, frequency: .daily, priority: 0)
    }
    
    //update the global total percentage
    mutating func updateGlobalTotalPercentage() {
        if globalHabitTotalAttempts == 0 {
            globalTotalPercentageCompleted = 0
            globalTotalPercentageMissed = 0
        } else {
            globalTotalPercentageCompleted = Double(totalCompleted) / Double(globalHabitTotalAttempts)
            globalTotalPercentageMissed = Double(totalMissed) / Double(globalHabitTotalAttempts)
        }
    }
    
    // Toggle habit as skipped
    mutating func toggleSkipped() {
        isSkipped.toggle()
    }
    
    // Mark habit as complete
    mutating func markComplete() {
        if isSkipped {
            isSkipped = false
            totalSkipped += 1
        }
        isComplete = true
        currentAmount = goalAmount
        datesCompleted.append(Date().startOfDay)
        streak += 1
    }
    
    // Mark habit as incomplete
    mutating func markIncomplete() {
        if isSkipped {
            isSkipped = false
        }
        isComplete = false
//        currentAmount = 0
        datesCompleted.removeLast()
        streak -= 1
    }
    
    // once due date passes and habit is not complete reset streak
    mutating func missed() {
        if !isSkipped {
            streak = 0
            isComplete = false
            totalMissed += 1
            globalHabitTotalAttempts += 1
            // add to missed days amount
            missedDaysAmount[Date().startOfDay] = (currentAmount/goalAmount)
            currentAmount = 0
        }
        
        if Frequency.daily == frequency {
            dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        } else if Frequency.weekly == frequency {
            dueDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
        } else if Frequency.monthly == frequency {
            dueDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
        }
        isSkipped = false
        updateGlobalTotalPercentage()
    }
    
    // once due date is hit and habit is complete reset the due date
    mutating func hit() {
        isComplete = false
        currentAmount = 0
        totalCompleted += 1
        globalHabitTotalAttempts += 1
        if streak > highestStreak {
            highestStreak = streak
        }
        
        if Frequency.daily == frequency {
            // add 1 day to the dueDate
            dueDate = dueDate.addingTimeInterval(86400)
        } else if Frequency.weekly == frequency {
            // add 1 week to the dueDate
            dueDate = dueDate.addingTimeInterval(604800)
        } else if Frequency.monthly == frequency {
            // add 1 month to the dueDate
            dueDate = dueDate.addingTimeInterval(2592000)
        }
        isSkipped = false
        updateGlobalTotalPercentage()
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
        } else {
            print("\(title) is not due yet")
        }
    }
    
}

extension Habit {
    static let testHabits: [Habit] =
    [
        Habit(
            title: "Water plants",
            content: "Monstera, Snake Plant, Venus Fly Trap, and the Cactus.",
            theme: .organicGreen,
            streak: 3,
            frequency: .daily,
            priority: 3
            
        ),
        Habit(
            title: "Practice Basketball",
            content: "",
            theme: .organicRed,
            streak: 6,
            frequency: .weekly,
            priority: 2
        ),
        Habit(
            title: "Clean the house",
            content: "Dishes, Laundry, and the Floors.",
            theme: .organicBlue,
            streak: 9,
            frequency: .monthly,
            priority: 1
        ),
        Habit(
            title: "Water plants",
            content: "Monstera, Snake Plant, Venus Fly Trap, and the Cactus.",
            theme: .organicGreen,
            streak: 3,
            frequency: .daily,
            priority: 3
            
        ),
        Habit(
            title: "Practice Basketball",
            content: "",
            theme: .organicRed,
            streak: 6,
            frequency: .weekly,
            priority: 2
        ),
        Habit(
            title: "Clean the house",
            content: "Dishes, Laundry, and the Floors.",
            theme: .organicBlue,
            streak: 9,
            frequency: .monthly,
            priority: 1
        ),
        Habit(
            title: "Water plants",
            content: "Monstera, Snake Plant, Venus Fly Trap, and the Cactus.",
            theme: .organicGreen,
            streak: 3,
            frequency: .daily,
            priority: 3
            
        ),
        Habit(
            title: "Practice Basketball",
            content: "",
            theme: .organicRed,
            streak: 6,
            frequency: .weekly,
            priority: 2
        ),
        Habit(
            title: "Clean the house",
            content: "Dishes, Laundry, and the Floors.",
            theme: .organicBlue,
            streak: 9,
            frequency: .monthly,
            priority: 1
        )
    ]
}
