//
//  AppData.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

@MainActor
class AppData: ObservableObject {
    @Published var account: Account = Account()

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("account.data")
    }
    
    
    func load() async throws {
        let task = Task<Account, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return Account()
            }
            let accounts = try JSONDecoder().decode(Account.self, from: data)
            return accounts
        }
        let account = try await task.value
        self.account = account
    }
    
    
    func save(account: Account) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(account)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    
    
}
