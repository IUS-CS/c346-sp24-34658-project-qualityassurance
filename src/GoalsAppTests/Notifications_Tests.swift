//
//  Notifications_Tests.swift
//  GoalsAppTests
//
//  Created by Garrison Creek on 4/22/24.
//

import XCTest
import UserNotifications
@testable import GoalsApp

final class Notifications_Tests: XCTestCase {
       var notificationManager: NotificationManager!
       
       override func setUp() {
           super.setUp()
           notificationManager = NotificationManager()
       }
       
       override func tearDown() {
           notificationManager = nil
           super.tearDown()
       }
       
       func testRequestPermission() {
           let expectation = XCTestExpectation(description: "Request Notification Permission")
           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
               expectation.fulfill()
               if let error = error {
                   XCTFail("Error requesting notification permission: \(error.localizedDescription)")
               }
           }
           wait(for: [expectation], timeout: 2.0)
       }
       
       func testScheduleNotification() {
           let habit = Habit(
               title: "Test Habit",
               content: "Test Content",
               theme: .organicGreen,
               streak: 5,
               frequency: .daily
           )
           
           notificationManager.scheduleNotification(for: habit)
           
           let expectation = XCTestExpectation(description: "Check for Scheduled Notification")
           
           UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
               let habitRequest = requests.first { $0.identifier == habit.id.uuidString }
               XCTAssertNotNil(habitRequest, "Notification should be scheduled for the habit")
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 2.0)
       }
       
       func testCancelHabitNotification() {
           let habit = Habit(
               title: "Test Habit",
               content: "Test Content",
               theme: .organicGreen,
               streak: 5,
               frequency: .daily
           )
           
           notificationManager.scheduleNotification(for: habit)
           notificationManager.cancelHabitNotification(for: habit)
           
           let expectation = XCTestExpectation(description: "Check for Cancelled Habit Notification")
           
           UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
               let habitRequest = requests.first { $0.identifier == habit.id.uuidString }
               XCTAssertNil(habitRequest, "Notification for habit should be cancelled")
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 2.0)
       }
       
       func testCancelAllNotifications() {
           let habit = Habit(
               title: "Test Habit",
               content: "Test Content",
               theme: .organicGreen,
               streak: 5,
               frequency: .daily
           )
           
           notificationManager.scheduleNotification(for: habit)
           notificationManager.cancelAllNotifications()
           
           let expectation = XCTestExpectation(description: "Check for Cancelled All Notifications")
           
           UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
               XCTAssertEqual(requests.count, 0, "All pending notifications should be cancelled")
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 2.0)
       }
}
