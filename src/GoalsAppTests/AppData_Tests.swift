//
//  AppData_Tests.swift
//  GoalsAppTests
//
//  Created by Garrison Creek on 4/22/24.
//

import XCTest
@testable import GoalsApp

final class AppData_Tests: XCTestCase {
    var appData: AppData!
    
    @MainActor override func setUp() {
        super.setUp()
        appData = AppData()
    }
    
    override func tearDown() {
        appData = nil
        super.tearDown()
    }
    
    @MainActor func testDefaultAccount() {
        // Ensure default account has expected settings
        let defaultAccount = appData.account
        XCTAssertTrue(defaultAccount.notificationsEnabled, "Notifications should be enabled by default")
        XCTAssertTrue(defaultAccount.showCompletedHabits, "Completed habits should be shown by default")
        XCTAssertTrue(defaultAccount.celebrationsEnabled, "Celebrations should be enabled by default")
    }
    
    @MainActor func testSaveAndLoadAccount() async throws {
        // Create a custom account to test saving
        let customAccount = Account(accentTheme: .accentRed, backgroundTheme: .Dark)
        try await appData.save(account: customAccount)

        // Load the account
        let newAppData = AppData()
        try await newAppData.load()

        // Check if the loaded account matches the saved one
        XCTAssertEqual(newAppData.account.accentTheme, customAccount.accentTheme, "Accent theme should match the saved data")
        XCTAssertEqual(newAppData.account.backgroundTheme, customAccount.backgroundTheme, "Background theme should match the saved data")
    }

    @MainActor func testFileExistsAfterSave() async throws {
        // Save a custom account
        let customAccount = Account(accentTheme: .accentOrange, backgroundTheme: .Dark)
        try await appData.save(account: customAccount)

        // Check if the file was created
        let fileURL = try AppData.fileURL()
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path), "The account data file should be created after saving")
    }

    @MainActor func testLoadWhenNoFile() async throws {
        // Remove any existing file
        let fileURL = try AppData.fileURL()
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }

        // Load account data
        try await appData.load()

        // Verify the default account
        XCTAssertTrue(appData.account.notificationsEnabled, "Notifications should be enabled in the default account")
    }
}
