//
//  Goal.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

struct Goal: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, content: String, theme: Theme) {
        self.id = id
        self.title = title
        self.content = content
        self.theme = theme
    }
    
    static var emptyGoal: Goal {
        Goal(title: "", content: "", theme: .sky)
    }
    
}

extension Goal {
    static let testGoals: [Goal] =
    [
        Goal(title: "Design",
             content: "Designing the app and its features",
             theme: .yellow),
        Goal(title: "App Dev",
             content: "Building the app and its features",
             theme: .orange),
        Goal(title: "Web Dev",
             content: "Building the app and its features",
             theme: .poppy)
    ]
}
