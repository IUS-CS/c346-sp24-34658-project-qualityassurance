//
//  Habit_Tests.swift
//  GoalsAppTests
//
//  Created by Garrison Creek on 4/1/24.
//

//import XCTest
//
//final class Habit_Tests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
import XCTest

final class Habit_Tests: XCTestCase {

    var habit: Habit!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        habit = Habit(name: "Exercise", target: 30)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        habit = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(habit)
        XCTAssertEqual(habit.name, "Exercise")
        XCTAssertEqual(habit.target, 30)
        XCTAssertEqual(habit.progress, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            for _ in 0..<1000 {
                        habit.updateProgress(amount: 1) // Assuming updateProgress() method increments the progress by 1
                    }
        }
    }

}
