//
//  HabitTheme.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/12/24.
//

import Foundation
import SwiftUI

enum HabitTheme: String, CaseIterable, Identifiable, Codable {
    
// Gradient Theme Colors
    case gradientLime
    case gradientLime2
    case gradientOcean
    case gradientOcean2
    case gradientPear
    case gradientPear2
    case gradientSpace
    case gradientSpace2
    case gradientPink
    case gradientPink2
    case gradientSanguine
    case gradientSanguine2
    case gradientWinter
    case gradientWinter2

// Standard Theme Colors
    
    // Organic
    case organicBlue
    case organicBrown
    case organicGreen
    case organicRed
    case organicWhite
    
    // Pop
    case popBlue
    case popGreen
    case popPink
    case popYellow
    case popRed
    
    // Sunset
    case sunsetBlue
    case sunsetTeal
    case sunsetYellow
    case sunsetOrange
    case sunsetRed
    
    // Bubblegum
    case bubblegumYellow
    case bubblegumRed
    case bubblegumPink
    case bubblegumBlue
    case bubblegumTeal
    
    // Halloween
    case halloweenDarkPurple
    case halloweenPurple
    case halloweenTeal
    case halloweenGreen
    case halloweenOrange
    case halloweenDarkOrange
    case halloweenRed
    
    // Easter
    case easterBlue
    case easterPink
    case easterPurple
    case easterYellow
    case easterGreen
    
    var complementaryColor: Color {
        switch self {
        case .organicGreen: return .white
            
        default: return .black
        }
    }
    
    var standardColor: Color {
        // Standard Theme Colors
        return Color(rawValue)
    }
    
    // Gradient Rework
    var mainColor: LinearGradient {
        switch self {
            // GRADIENT COLORS
        case .gradientLime: return LinearGradient(gradient: Gradient(colors: [Color(.gradientLime), Color(.gradientLime2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientOcean: return LinearGradient(gradient: Gradient(colors: [Color(.gradientOcean), Color(.gradientOcean2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientPear: return LinearGradient(gradient: Gradient(colors: [Color(.gradientPear), Color(.gradientPear2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientPink: return LinearGradient(gradient: Gradient(colors: [Color(.gradientPink), Color(.gradientPink2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientSanguine: return LinearGradient(gradient: Gradient(colors: [Color(.gradientSanguine), Color(.gradientSanguine2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientSpace: return LinearGradient(gradient: Gradient(colors: [Color(.gradientSpace), Color(.gradientSpace2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientWinter: return LinearGradient(gradient: Gradient(colors: [Color(.gradientWinter), Color(.gradientWinter2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientLime2: return LinearGradient(gradient: Gradient(colors: [Color(.gradientLime), Color(.gradientLime2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientOcean2: return LinearGradient(gradient: Gradient(colors: [Color(.gradientOcean), Color(.gradientOcean2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientPear2: return LinearGradient(gradient: Gradient(colors: [Color(.gradientPear), Color(.gradientPear2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientPink2: return LinearGradient(gradient: Gradient(colors: [Color(.gradientPink), Color(.gradientPink2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientSanguine2: return LinearGradient(gradient: Gradient(colors: [Color(.gradientSanguine), Color(.gradientSanguine2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientSpace2: return LinearGradient(gradient: Gradient(colors: [Color(.gradientSpace), Color(.gradientSpace2)]), startPoint: .top, endPoint: .bottomTrailing)
        case .gradientWinter2: return LinearGradient(gradient: Gradient(colors: [Color(.gradientWinter), Color(.gradientWinter2)]), startPoint: .top, endPoint: .bottomTrailing)
            
            // STANDARD COLORS
        default: return LinearGradient(gradient: Gradient(colors: [Color(rawValue), Color(rawValue)]), startPoint: .top, endPoint: .bottomTrailing)
        }
    }
    
    var groupName: String {
        switch self {
            // Group 1 is Gradients
        case .gradientLime, .gradientOcean, .gradientPear, .gradientPink, .gradientSanguine, .gradientSpace, .gradientWinter, .gradientLime2, .gradientOcean2, .gradientPear2, .gradientPink2, .gradientSanguine2, .gradientSpace2, .gradientWinter2: return "Gradient"
            // Group 2 is Organic
        case .organicBlue, .organicBrown, .organicGreen, .organicRed, .organicWhite: return "Organic"
            // Group 3 is Pop
        case .popBlue, .popGreen, .popYellow, .popPink, .popRed: return "Pop"
            // Group 4 is Sunset
        case .sunsetBlue, .sunsetOrange, .sunsetRed, .sunsetTeal, .sunsetYellow: return "Sunset"
            // Group 5 is Bubblegum
        case .bubblegumRed, .bubblegumBlue, .bubblegumPink, .bubblegumTeal, .bubblegumYellow: return "Bubblegum"
            // Group 6 is Easter
        case .easterBlue, .easterPink, .easterGreen, .easterPurple, .easterYellow : return "Easter"
            // Group 7 is Halloween
        case .halloweenRed, .halloweenDarkOrange, .halloweenDarkPurple, .halloweenGreen, .halloweenOrange, .halloweenPurple, .halloweenTeal: return "Halloween"
        }
    }
    
    var name: String {
        rawValue.capitalized.replacingOccurrences(of: groupName, with: "\(self.groupName) ").capitalized
    }
    
    var isGradient: Bool {
        switch self {
        case .gradientLime, .gradientOcean, .gradientPear, .gradientPink, .gradientSanguine, .gradientSpace, .gradientWinter, .gradientLime2, .gradientOcean2, .gradientPear2, .gradientPink2, .gradientSanguine2, .gradientSpace2, .gradientWinter2: return true
        default: return false
        }
    }
    var showGradientOption: Bool {
        switch self {
        case .gradientLime, .gradientOcean, .gradientPear, .gradientPink, .gradientSanguine, .gradientSpace, .gradientWinter : return true
            
        default: return false
        }
    }
    
    var id: String {
        name
    }
}
