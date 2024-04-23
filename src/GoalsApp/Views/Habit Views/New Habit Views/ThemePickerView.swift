//
//  ThemePickerView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/12/24.
//

import SwiftUI

struct ThemePickerView: View {
    @Binding var selection: HabitTheme
    @EnvironmentObject private var appData: AppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ScrollView {
            VStack { // Organic Palette
                HStack {
                    Text("Organic Palette")
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 25)
                
                HStack (spacing: 0) {
                    ForEach(HabitTheme.allCases.filter({ $0.groupName == "Organic"})) { theme in
                        if appData.account.activeHabitThemes.contains(theme) {
                            Button {
                                print("Theme selected duplicate! \(theme.name)")
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Image(systemName: "x.circle")
                                            .font(.title)
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        } else {
                            Button {
                                print("Theme selected \(theme.name)")
                                selection = theme
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: UIScreen.main.bounds.width - 25)
                .frame(height: 100)
            } // Organic Palette
            
            VStack { // Pop Palette
                HStack {
                    Text("Pop Palette")
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 25)
                
                HStack (spacing: 0) {
                    ForEach(HabitTheme.allCases.filter({ $0.groupName == "Pop"})) { theme in
                        if appData.account.activeHabitThemes.contains(theme) {
                            Button {
                                print("Theme selected duplicate! \(theme.name)")
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Image(systemName: "x.circle")
                                            .font(.title)
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        } else {
                            Button {
                                print("Theme selected \(theme.name)")
                                selection = theme
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: UIScreen.main.bounds.width - 25)
                .frame(height: 100)
            } // Pop Palette
            
            VStack { // Sunset Palette
                HStack {
                    Text("Sunset Palette")
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 25)
                
                HStack (spacing: 0) {
                    ForEach(HabitTheme.allCases.filter({ $0.groupName == "Sunset"})) { theme in
                        if appData.account.activeHabitThemes.contains(theme) {
                            Button {
                                print("Theme selected duplicate! \(theme.name)")
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Image(systemName: "x.circle")
                                            .font(.title)
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        } else {
                            Button {
                                print("Theme selected \(theme.name)")
                                selection = theme
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: UIScreen.main.bounds.width - 25)
                .frame(height: 100)
            } // Sunset Palette
            
            VStack { // Bubblegume Palette
                HStack {
                    Text("Bubblegum Palette")
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 25)
                
                HStack (spacing: 0) {
                    ForEach(HabitTheme.allCases.filter({ $0.groupName == "Bubblegum"})) { theme in
                        if appData.account.activeHabitThemes.contains(theme) {
                            Button {
                                print("Theme selected duplicate! \(theme.name)")
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Image(systemName: "x.circle")
                                            .font(.title)
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        } else {
                            Button {
                                print("Theme selected \(theme.name)")
                                selection = theme
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: UIScreen.main.bounds.width - 25)
                .frame(height: 100)
            } // Bubblegum Palette
            
            VStack { // Halloween Palette
                HStack {
                    Text("Halloween Palette")
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 25)
                
                HStack (spacing: 0) {
                    ForEach(HabitTheme.allCases.filter({ $0.groupName == "Halloween"})) { theme in
                        if appData.account.activeHabitThemes.contains(theme) {
                            Button {
                                print("Theme selected duplicate! \(theme.name)")
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Image(systemName: "x.circle")
                                            .font(.title)
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        } else {
                            Button {
                                print("Theme selected \(theme.name)")
                                selection = theme
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: UIScreen.main.bounds.width - 25)
                .frame(height: 100)
            } // Halloween Palette
            
            VStack { // Easter Palette
                HStack {
                    Text("Easter Palette")
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 25)
                
                HStack (spacing: 0) {
                    ForEach(HabitTheme.allCases.filter({ $0.groupName == "Easter"})) { theme in
                        if appData.account.activeHabitThemes.contains(theme) {
                            Button {
                                print("Theme selected duplicate! \(theme.name)")
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Image(systemName: "x.circle")
                                            .font(.title)
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        } else {
                            Button {
                                print("Theme selected \(theme.name)")
                                selection = theme
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: UIScreen.main.bounds.width - 25)
                .frame(height: 100)
            } // Easter Palette
            
            VStack { // Gradients Palette
                HStack {
                    Text("Gradients")
                        .font(.title2)
                        .fontWeight(.bold)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 25)
                
                VStack (spacing: 0) {
                    ForEach(HabitTheme.allCases.filter({ $0.isGradient == true && $0.showGradientOption == true })) { theme in
                        
                        if appData.account.activeHabitThemes.contains(theme) {
                            Button {
                                print("Theme selected duplicate! \(theme.name)")
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Image(systemName: "x.circle")
                                            .font(.title)
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        } else {
                            Button {
                                print("Theme selected \(theme.name)")
                                selection = theme
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(theme.mainColor)
                                    .frame(height: 100)
                                    .scaledToFill()
                                    .overlay(
                                        Text(theme.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .monospaced()
                                            .foregroundStyle(theme.complementaryColor)
                                    )
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: UIScreen.main.bounds.width - 25)
                //                .frame(height: 100)
            } // Gradients Palette
        }
        .scrollIndicators(.hidden)
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
    }
}

#Preview {
    ThemePickerView(selection: .constant(HabitTheme.allCases[0]))
        .environmentObject(AppData())
}
