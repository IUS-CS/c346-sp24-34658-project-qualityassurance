//
//  BackgroundTheme.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

enum BackgroundTheme: String, CaseIterable, Identifiable, Codable {
    
    case auto
    case white
    case black
    case navy
    
    var complementaryColor: Color {
        switch self {
        case .auto: if UserDefaults.standard.bool(forKey: "darkMode") {
            return .black
        } else {
            return .white
        }
        case .white: return .black
        case .black, .navy: return .white
        }
    }
    
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
