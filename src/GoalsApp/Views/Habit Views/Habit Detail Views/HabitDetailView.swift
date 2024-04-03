//
//  HabitDetailView.swift
//  GoalsApp
//
//  Created by Garrison Creek on 2/20/24.
//

import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject private var appData: AppData
    @State var selectedHabit: Habit?
    let namespace: Namespace.ID
    
    enum ChartType: String, CaseIterable {
        case weekly = "Weekly"
        case monthly = "Monthly"
        case yearly = "Yearly"
    }
    
    @State var selectedChartType: ChartType = .monthly
    
    
    var body: some View {
        VStack () {
            ScrollView () { // top layer item list stack
                HStack {
                    ExpandedHabitCardView(habit: $selectedHabit.toUnwrapped(defaultValue: Habit.emptyHabit))
                        .scaleEffect(1.07)
                        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        .matchedGeometryEffect(id: selectedHabit!.id, in: namespace, properties: .frame, anchor: .top, isSource: selectedHabit != nil)
                } // HabitCardView
                .padding(.top, 3)
                
                HStack {
                    Text("Charts")
                        .font(.title)
                        .fontWeight(.black)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    
                    Spacer()
                    
                    Picker("Chart Type", selection: $selectedChartType) {
                        ForEach(ChartType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .frame(width: 190)
                    .pickerStyle(.segmented)
                } // Calendar and Chart Picker
                .frame(width: UIScreen.main.bounds.width - 50)
                .padding(.top)
                
                switch selectedChartType {
                    case .weekly:
                        withAnimation ( .smooth(duration: 2.0)){
                            WeeklyHabitCalendarView(selectedHabit: selectedHabit!)
                                .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                .padding(.top)
                        }
                        
                    case .monthly:
                        withAnimation ( .smooth(duration: 2.0)){
                            MonthlyHabitCalendarView(selectedHabit: selectedHabit!)
                                .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                .padding(.top)
                        }
                        
                    case .yearly:
                        withAnimation ( .smooth(duration: 2.0)){
                            YearlyHabitCalendarView(selectedHabit: selectedHabit!)
                                .preferredColorScheme(appData.account.backgroundTheme.colorScheme)
                                .padding(.top)
                        }
                } // Displaying the weekly, monthly, or yearly charts
                HStack {
                    Text("Stats")
                        .font(.title)
                        .fontWeight(.black)
                        .monospaced()
                        .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                    
                    Spacer()
                } // Stats Title
                .frame(width: UIScreen.main.bounds.width - 50)
                .padding(.top)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("Current Streak")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                                
                                Text("\(selectedHabit!.streak)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Current Streak
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("Highest Streak")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                                
                                Text("\(selectedHabit!.highestStreak)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Highest Streak
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("Date Created")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                
                                Text(selectedHabit!.dateCreated.formatted(.dateTime.year(.twoDigits).month().day()))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Date Created
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("Completed")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                Text("\(selectedHabit!.totalCompleted)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Total Completed
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("Total Skipped")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "moon.zzz.fill")
                                    .foregroundStyle(.purple)
                                    .font(.title)
                                Text("\(selectedHabit!.totalSkipped)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Total Skipped
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("Total Missed")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "x.circle")
                                    .foregroundStyle(.red)
                                    .font(.title)
                                Text("\(selectedHabit!.totalMissed)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Total Missed
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("Total Skipped")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "moon.zzz.fill")
                                    .foregroundStyle(.purple)
                                    .font(.title)
                                Text("\(selectedHabit!.totalSkipped)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Total Skipped
                    
                    ZStack {
                        // background glass container
                        Rectangle()
                            .fill(selectedHabit!.theme.mainColor.secondary)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .frame(width: (UIScreen.main.bounds.width - 75)/2)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
                        
                        VStack {
                            Text("% Complete")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedHabit!.theme.complementaryColor)
                            Spacer()
                            HStack {
                                Spacer()
                                Text("\(selectedHabit!.globalTotalPercentageCompleted, specifier: "%.2f")%")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedHabit!.theme.complementaryColor)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    } // Total Skipped
                    
                } // Stats Grid Collection
                ZStack {
                    // background glass container
                    Rectangle()
                        .fill(selectedHabit!.theme.mainColor.secondary)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)

                    VStack {
                        Text("Due Date: \(selectedHabit!.dueDate.formatted(.dateTime.year().month().day().hour().minute()))")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(selectedHabit!.theme.complementaryColor)
                    }
                    .padding()
                } // Due Date Block
                
                Spacer()
            } // END OF SCROLLVIEW
            .refreshable {
                print("Refreshing...")
                selectedHabit!.update()
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height - 210)
        .background(.thinMaterial)
        
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.3), radius: 7, x: 7, y: 7)
    }
}

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(selectedHabit: Habit.testHabits.first, namespace: Namespace().wrappedValue)
            .environmentObject(AppData())
    }
}
