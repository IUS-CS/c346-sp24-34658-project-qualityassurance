//
//  Account.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

struct Account: Identifiable, Codable {
    var id = UUID()
    var accentTheme: Accent
    var backgroundTheme: BackgroundTheme
    var notificationsEnabled: Bool = true
    var habits: [Habit] = []
    
    // INIT
    init() {
        accentTheme = .blue
        backgroundTheme = .white
    }
    
    init(accentTheme: Accent, backgroundTheme: BackgroundTheme) {
        self.accentTheme = accentTheme
        self.backgroundTheme = backgroundTheme
    }
}
