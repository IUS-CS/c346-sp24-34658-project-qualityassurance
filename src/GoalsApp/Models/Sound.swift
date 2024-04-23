//
//  Sound.swift
//  GoalsApp
//
//  Created by Garrison Creek on 4/11/24.
//

import Foundation

enum Sound: String, CaseIterable, Identifiable, Codable {
    
    var id: String {
        name
    }
    
    var name: String {
        rawValue
    }
    
    case Basso = "Basso"
    case Blow = "Blow"
    case Bottle = "Bottle"
    case Frog = "Frog"
    case Funk = "Funk"
    case Glass = "Glass"
    case Hero = "Hero"
    case Morse = "Morse"
    case Ping = "Ping"
    case Pop = "Pop"
    case Purr = "Purr"
    case Sosumi = "Sosumi"
    case Submarine = "Submarine"
    case Tink = "Tink"
}
