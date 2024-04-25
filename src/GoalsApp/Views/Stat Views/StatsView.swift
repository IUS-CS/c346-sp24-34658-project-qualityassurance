//
//  StatsView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/19/24.
//

import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject private var appData: AppData
    @State private var isPresentingAccountView = false
    
    var body: some View {
        ZStack {
            Color(appData.account.backgroundTheme.mainColor).ignoresSafeArea()
            
            VStack { 
                HStack { // TOP TAB BAR
                    Text("Stats")
                        .font(.largeTitle)
                        .padding(.leading, 10)
                        .fontWeight(.black)
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    Spacer()
                    Button(action: {
                        isPresentingAccountView = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.title)
                            .foregroundStyle(appData.account.accentTheme.mainColor)
                    }
                } // TOP TAB BAR
                .offset(y: -3)
                .padding(.leading)
                .padding(.trailing)
                
                
                ScrollView {
                    ZStack { // Account Stats Card
                        Rectangle()
                            .fill(appData.account.backgroundTheme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 25), height: 100)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        HStack {
                            Spacer()
                            VStack {
                                Text("\(appData.account.acctBestStreak)")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                
                                Text("BEST STREAK")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(appData.account.backgroundTheme.complementaryColor)
                            }
                            Spacer()
                            VStack {
                                Text("\(appData.account.acctAllTimeCompletionRate * 100, specifier: "%.0f") %")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                
                                Text("ALL TIME")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(appData.account.backgroundTheme.complementaryColor)
                            }
                            Spacer()
                            VStack {
                                Text("\(appData.account.acctTotalCompletions)")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                
                                Text("COMPLETIONS")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(appData.account.backgroundTheme.complementaryColor)
                            }
                            Spacer()
                        }
                    } // Account Stats Card
                    .background(appData.account.backgroundTheme.mainColor)
                    
                    
                    // Progress Bar Chart View
                        ProgressBarChartView()
                        .background(appData.account.backgroundTheme.mainColor)
                        .padding(.top, 40)
                        .padding(.bottom, 25)
                    
                    HStack {
                        ProgressPieChartView()

                        Spacer()
                        
                        ProgressPieChartView()
                    }
                    .frame(width: UIScreen.main.bounds.width - 25)
                } // END OF SCROLL VIEW HOLDING STATS
                .scrollIndicators(.hidden)
                .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                .sheet(isPresented: $isPresentingAccountView) {
                    AccountSettingsView(isPresentingAccountView: $isPresentingAccountView)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                }
            }
            
        }
    }
}

#Preview {
    StatsView()
        .environmentObject(AppData())
}
