//
//  AudioPickerView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 4/11/24.
//

import SwiftUI

struct AudioPickerView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var selection: Sound
    var audioSetting: String
    
    var body: some View {
        Picker(audioSetting, selection: $selection) {
            ForEach(Sound.allCases) { sound in
                Text(sound.name)
                    .tag(sound)
            }
        }
        .pickerStyle(.navigationLink)
        .onChange(of: selection) {
            SoundManager.instance.playSound(sound: selection)
        }
    }
}

#Preview {
    AudioPickerView(selection: .constant(.Basso), audioSetting: "Completion Sound")
        .environmentObject(AppData())
}
