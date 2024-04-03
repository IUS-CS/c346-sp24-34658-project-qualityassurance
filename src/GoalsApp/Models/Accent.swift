//
//  Accent.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import Foundation
import SwiftUI

enum Accent: String, CaseIterable, Identifiable, Codable {
    
    case Light
    case Dark
    case accentBlue
    case accentPurple
    case accentPink
    case accentRed
    case accentOrange
    case accentYellow
    case accentGreen
    case accentGraphite
    
    // Previous standard color version
//    var mainColor: Color {
//        switch self {
//        case .Light, .Dark, .accentBlue, .accentPurple, .accentPink, .accentRed, .accentOrange, .accentYellow, .accentGreen, .accentGraphite: return Color(rawValue)
//        }
//    }
    
    var standardColor: Color {
        return Color(rawValue)
    }
    
    // Gradient Rework
    var mainColor: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color(rawValue), Color(rawValue)]), startPoint: .top, endPoint: .bottomTrailing)
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
