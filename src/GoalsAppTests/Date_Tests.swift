//
//  Date_Tests.swift
//  GoalsAppTests
//
//  Created by Garrison Creek on 4/22/24.
//

import XCTest
@testable import GoalsApp

final class Date_Tests: XCTestCase {
    var today: Date!
    
    override func setUp() {
        super.setUp()
        // Set a known date to use in tests
        today = Date()
    }
    
    override func tearDown() {
        today = nil
        super.tearDown()
    }
    
    func testStartOfWeek() {
        let startOfWeek = today.startOfWeek
        let weekday = Calendar.current.component(.weekday, from: startOfWeek)
        XCTAssertEqual(weekday, Date.firstDayOfWeek, "Start of the week should begin with the expected first day")
    }
    
    func testEndOfWeek() {
        let endOfWeek = today.endOfWeek
        let diff = Calendar.current.dateComponents([.day], from: today.startOfWeek, to: endOfWeek).day
        XCTAssertEqual(diff, 6, "End of the week should be six days after the start of the week")
    }
    
    func testStartOfMonth() {
        let startOfMonth = today.startOfMonth
        let day = Calendar.current.component(.day, from: startOfMonth)
        XCTAssertEqual(day, 1, "Start of the month should be the first day")
    }
    
    func testEndOfMonth() {
        let endOfMonth = today.endOfMonth
        let day = Calendar.current.component(.day, from: endOfMonth)
        let lastDay = Calendar.current.range(of: .day, in: .month, for: today.startOfMonth)!.count
        XCTAssertEqual(day, lastDay, "End of the month should be the last day")
    }
    
    func testStartOfPreviousMonth() {
        let startOfPreviousMonth = today.startOfPreviousMonth
        let expectedDate = Calendar.current.date(byAdding: .month, value: -1, to: today.startOfMonth)
        XCTAssertEqual(startOfPreviousMonth, expectedDate!.startOfMonth, "Start of the previous month should be correct")
    }
    
    func testNumberOfDaysInMonth() {
        let numberOfDays = today.numberOfDaysInMonth
        let expectedDays = Calendar.current.range(of: .day, in: .month, for: today.startOfMonth)!.count
        XCTAssertEqual(numberOfDays, expectedDays, "Number of days in the month should match expected count")
    }
    
    func testRandomDateWithinLastThreeMonths() {
        let randomDate = today.randomDateWithinLastThreeMonths
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: today)
        
        XCTAssertGreaterThanOrEqual(randomDate, threeMonthsAgo!, "Random date should be within the last three months")
        XCTAssertLessThanOrEqual(randomDate, today, "Random date should not exceed today's date")
    }
    
    func testEndOfDay() {
        let endOfDay = today.endOfDay
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today.startOfDay)!
        XCTAssertEqual(endOfDay, startOfTomorrow.addingTimeInterval(-1), "End of the day should be one second before the start of the next day")
    }
    
    
    func testFullMonthNames() {
        let fullMonthNames = Date.fullMonthNames
        XCTAssertEqual(fullMonthNames.count, 12, "There should be twelve full month names")
    }
}
