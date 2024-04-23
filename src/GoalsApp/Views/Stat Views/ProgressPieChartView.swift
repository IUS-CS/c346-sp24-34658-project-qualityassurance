//
//  ProgressPieChartView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 3/23/24.
//

import SwiftUI
import Charts

struct ChartDataSet: Identifiable, Equatable {
    var id = UUID()
    var category: String
    var amount: Double
    var color: String
}

struct ProgressPieChartView: View {
    @EnvironmentObject private var appData: AppData
    
    var body: some View {
        
        let totalData = [
            ChartDataSet(category: "Complete", amount: Double(appData.account.activeHabitsComplete), color: "green"),
            ChartDataSet(category: "Incomplete", amount: Double(appData.account.activeHabitsIncomplete), color: "red"),
            ChartDataSet(category: "Skipped", amount: Double(appData.account.activeHabitsSkipped), color: "purple")
        ]
        
        let chartColors: [Color] = [
          .green, .red, .purple
        ]
        
        // Pie chart showing habits done, habits to do, and habits skipped
        
        
        ZStack { // Productivity Graph
            Rectangle()
                .fill(appData.account.backgroundTheme.mainColor.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .frame(width: (UIScreen.main.bounds.width - 50)/2)
                .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
            
            VStack {
                Text("Habit Progress")
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    .padding(.top, 10)
                
                Chart(totalData) { data in
                    SectorMark(
                        angle: .value("Amount", data.amount),
                        innerRadius: .ratio(0.6),
                        angularInset: 3.0
                    )
                    .cornerRadius(6.0)
                    .foregroundStyle(by: .value("category", data.category))
                    .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                }
                .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                .chartLegend(.visible)
                .chartForegroundStyleScale(domain: .automatic, range: chartColors)
                .padding()
            }
        } // Productivity Graph
        .frame(width: (UIScreen.main.bounds.width - 50)/2, height: 200)
        .padding(.top, 10)
    }
}

#Preview {
    ProgressPieChartView()
        .environmentObject(AppData())
}
