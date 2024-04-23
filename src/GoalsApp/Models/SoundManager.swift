//
//  SoundManager.swift
//  GoalsApp
//
//  Created by Garrison Creek on 4/11/24.
//

import Foundation
import AVFoundation

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
//    enum SoundOption: String {
//        case celebration = "Hero"
//        case failure = "Bottle"
//        case selection = "Pop"
//    }
    
    func playSound(sound: Sound) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".aiff") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
    
}
