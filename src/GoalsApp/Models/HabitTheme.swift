//
//  HabitTheme.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/12/24.
//

import Foundation
import SwiftUI

enum HabitTheme: String, CaseIterable, Identifiable, Codable {
    
    case organicBlue
    case organicBrown
    case organicGreen
    case organicRed
    case organicWhite
    
    case popBlue
    case popGreen
    case popPink
    case popYellow
    
    case sunsetBlue
    case sunsetOrange
    case sunsetRed
    case sunsetTeal
    case sunsetYellow
    
    
    var complementaryColor: Color {
        switch self {
        case .organicBlue, .organicBrown, .organicRed, .organicWhite, .popBlue, .popGreen, .popPink, .popYellow, .sunsetBlue, .sunsetOrange, .sunsetRed, .sunsetTeal, .sunsetYellow: return .black
        case .organicGreen: return .white
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
}
