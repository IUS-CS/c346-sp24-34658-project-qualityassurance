//
//  Account_Tests.swift
//  GoalsAppTests
//
//  Created by Garrison Creek on 4/22/24.
//

import XCTest
@testable import GoalsApp

final class Account_Tests: XCTestCase {
    
    var account: Account!
    
    override func setUp() {
        super.setUp()
        // Initialize a default account with some test data
        account = Account()
        
        // Create a test habit to add to the account
        let testHabit = Habit(
            title: "Test Habit",
            content: "Test Content",
            theme: .organicGreen,
            streak: 5,
            frequency: .daily
        )
        
        account.habits.append(testHabit)
    }
    
    override func tearDown() {
        account = nil
        super.tearDown()
    }
    
    func testDefaultAccountSettings() {
        XCTAssertTrue(account.notificationsEnabled, "Notifications should be enabled by default")
        XCTAssertTrue(account.showCompletedHabits, "Completed habits should be shown by default")
        XCTAssertTrue(account.celebrationsEnabled, "Celebrations should be enabled by default")
        XCTAssertTrue(account.hapticFeedbackEnabled, "Haptic feedback should be enabled by default")
        XCTAssertTrue(account.soundsEnabled, "Sounds should be enabled by default")
    }
    
    func testHabitFilterFunctions() {
        XCTAssertEqual(account.dailyHabits.count, 1, "There should be one daily habit")
        XCTAssertEqual(account.weeklyHabits.count, 0, "There should be no weekly habits")
        XCTAssertEqual(account.monthlyHabits.count, 0, "There should be no monthly habits")
    }
    
    func testDeleteHabit() {
        let habitToDelete = account.habits[0]
        account.deleteHabit(habitToDelete)
        XCTAssertEqual(account.habits.count, 0, "The habit should be deleted")
    }
    
    func testUpdateHabits() {
        // Manipulate the due date to force an update
        account.habits[0].dueDate = Date().addingTimeInterval(-86400) // Set due date to one day in the past
        account.habits[0].markComplete()
        account.updateHabits()
        
        XCTAssertEqual(account.habits[0].streak, 6, "The habit streak should increase when due date has passed")
    }
    
    func testStatTracking() {
        // Simulate the scenario where the best streak has increased
        // Manipulate the due date to force an update
        account.habits[0].dueDate = Date().addingTimeInterval(-86400) // Set due date to one day in the past
        account.habits[0].markComplete()
        account.updateHabits() // Ensure habits are updated to increase streak
        
        let expectedBestStreak = 6 // The updated streak
        XCTAssertEqual(account.acctBestStreak, expectedBestStreak, "Best streak should be updated to the expected value")
        
        // Calculate expected daily completion rate
        let totalHabits = account.habits.count
        let totalCompleted = account.habits.map { $0.periodCompletionRate }.reduce(0, +)
        let expectedCompletionRate = Double(totalCompleted) / Double(totalHabits)
        
        XCTAssertEqual(account.dailyCompletionRate, expectedCompletionRate, "Daily completion rate should be consistent with the habit updates")
    }
    
    func testInitializationWithParameters() {
        let customAccount = Account(accentTheme: .accentBlue, backgroundTheme: .Light)
        XCTAssertEqual(customAccount.accentTheme, .accentBlue, "Accent theme should be accentBlue")
        XCTAssertEqual(customAccount.backgroundTheme, .Light, "Background theme should be Light")
    }
}
