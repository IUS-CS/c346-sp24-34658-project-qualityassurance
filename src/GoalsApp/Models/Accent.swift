//
//  Accent.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

enum Accent: String, CaseIterable, Identifiable, Codable {

    case auto
    case white
    case black
    case blue
    case purple
    case pink
    case red
    case orange
    case yellow
    case green
    case graphite
    
    
    var mainColor: Color {
        if self == .auto && UserDefaults.standard.bool(forKey: "darkMode") {
            return Color(.white)
        } else if self == .auto {
            return Color.black
        } else {
            return Color(rawValue)
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
