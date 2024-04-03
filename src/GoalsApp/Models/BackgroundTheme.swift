//
//  BackgroundTheme.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI


enum BackgroundTheme: String, CaseIterable, Identifiable, Codable {
    
    case Light
    case Dark
    case navy
    
    var complementaryColor: Color {
        switch self {
        case .Light: return .black
        case .Dark, .navy: return .white
        }
    }
    
    var mainColor: Color {
        return Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
    
    var colorScheme: ColorScheme {
        switch self {
        case .Light: return .light
        case .Dark, .navy: return .dark
        }
    }
}
