//
//  Habit_Tests.swift
//  GoalsAppTests
//
//  Created by Garrison Creek on 4/1/24.
//

import XCTest
@testable import GoalsApp

final class Habit_Tests: XCTestCase {
    
    var habit: Habit!
        
        override func setUp() {
            super.setUp()
            // Create a default habit for testing
            habit = Habit(
                title: "Test Habit",
                content: "Test Content",
                theme: .organicGreen,
                streak: 5,
                frequency: .daily
            )
        }
        
        override func tearDown() {
            habit = nil
            super.tearDown()
        }
    
    func testHabitInitialization() {
        XCTAssertEqual(habit.title, "Test Habit")
        XCTAssertEqual(habit.content, "Test Content")
        XCTAssertEqual(habit.theme, .organicGreen)
        XCTAssertEqual(habit.streak, 5)
        XCTAssertEqual(habit.frequency, .daily)
        XCTAssertEqual(habit.icon, "bookmark.fill")
        XCTAssertEqual(habit.priority, .medium)
        XCTAssertEqual(habit.activeDays, [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday])
        XCTAssertFalse(habit.isComplete)
        XCTAssertFalse(habit.isSkipped)
    }
    
    func testMarkComplete() {
        habit.markComplete()
        XCTAssertTrue(habit.isComplete)
        XCTAssertEqual(habit.streak, 6) // The streak should increase
        XCTAssertEqual(habit.datesCompleted.count, 1) // A date should be added
    }

    func testMarkIncomplete() {
        habit.markComplete() // First mark as complete
        habit.markIncomplete() // Then mark as incomplete
        XCTAssertFalse(habit.isComplete)
        XCTAssertEqual(habit.streak, 5) // The streak should decrease
        XCTAssertEqual(habit.datesCompleted.count, 0) // The date should be removed
    }

    func testToggleSkipped() {
        habit.toggleSkipped()
        XCTAssertTrue(habit.isSkipped)
        habit.toggleSkipped()
        XCTAssertFalse(habit.isSkipped)
    }

    func testUpdateGlobalTotalPercentage() {
        habit.totalCompleted = 2
        habit.habitTotalAttempts = 4
        habit.updateCompletionPercentage()
        
        XCTAssertEqual(habit.habitTotalPercentageCompleted, 0.5) // 2/4 = 0.5
    }
    
    func testMissed() {
        habit.missed()
        XCTAssertEqual(habit.streak, 0)
        XCTAssertFalse(habit.isComplete)
        XCTAssertEqual(habit.totalMissed, 1)
        XCTAssertEqual(habit.habitTotalAttempts, 1)
        XCTAssertEqual(habit.missedDays_andAmount.count, 1) // Should have 1 missed day
    }

    func testHit() {
        habit.hit()
        XCTAssertFalse(habit.isComplete)
        XCTAssertEqual(habit.totalCompleted, 1)
        XCTAssertEqual(habit.habitTotalAttempts, 1)
        XCTAssertEqual(habit.currentAmount, 0) // Reset after hitting
    }
    
    func testAddActiveDay() {
        habit.removeActiveDay(day: .Sunday) // Remove one day for testing
        habit.addActiveDay(day: .Sunday)
        XCTAssertTrue(habit.activeDays.contains(.Sunday))
    }

    func testRemoveActiveDay() {
        habit.removeActiveDay(day: .Sunday)
        XCTAssertFalse(habit.activeDays.contains(.Sunday))
    }

}
