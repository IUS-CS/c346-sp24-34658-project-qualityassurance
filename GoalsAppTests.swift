//
//  GoalsAppTests.swift
//  GoalsAppTests
//
//  Created by Garrison Creek on 4/1/24.
//

//import XCTest
//
//final class GoalsAppTests: XCTestCase {
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
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
import XCTest

final class GoalsAppTests: XCTestCase {

    var viewController: viewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = viewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
    }

    func testAddGoal() throws {
        // Test adding a goal to the list
        let goalTitle = "Learn Swift"
        viewController.addGoal(title: goalTitle)
        
        // Assert that the goal was added successfully
        XCTAssertTrue(viewController.goals.contains(goalTitle))
    }

    func testRemoveGoal() throws {
        // Test removing a goal from the list
        let goalTitle = "Read a Book"
        viewController.addGoal(title: goalTitle)
        viewController.removeGoal(title: goalTitle)
        
        // Assert that the goal was removed successfully
        XCTAssertFalse(viewController.goals.contains(goalTitle))
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Measure the time it takes to add a goal
            let goalTitle = "Performance Test Goal"
            viewController.addGoal(title: goalTitle)
        }
    }

    
}
