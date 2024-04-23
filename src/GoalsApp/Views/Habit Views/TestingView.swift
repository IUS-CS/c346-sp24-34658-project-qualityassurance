
import SwiftUI

struct TestingView: View {
    @EnvironmentObject private var appData: AppData
    @Binding var habit: Habit
    
    @State private var offset: CGFloat = 0
    @State private var isDragging = false
    
    var body: some View {
        ZStack (alignment: .leading) {
            Rectangle()
                .fill(habit.theme.mainColor.secondary)
                .cornerRadius(15)
                .frame(height: 100)
                .frame(maxWidth: UIScreen.main.bounds.width - 50)
                .shadow(radius: 10)
            
            ZStack (alignment: .trailing) {
                Rectangle()
                    .fill(habit.theme.mainColor)
                    .cornerRadius(15)
                    .frame(width: calcPercent(), height: 100)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    let dragAmount = value.translation.width
                    let totalWidth = UIScreen.main.bounds.width - 50
                    
                    let dragPercentage = dragAmount / totalWidth
                    let updatedAmount = dragPercentage * CGFloat(habit.goalAmount)
                    let clampedAmount = min(max(updatedAmount, 0), CGFloat(habit.goalAmount))
                    
                    habit.currentAmount = Int(clampedAmount)
                }
                .onEnded { value in
                    withAnimation(.easeOut) {
                        if value.translation.width < 0 { // if the user swipes left
                            offset = 0
                            print("negative swipe setting to 0")
                        } else {
                            offset = calcPercent()
                            print ("positive swipe adding to total")
                        }
                    }
                }
        )
        .overlay(
            Text("\(habit.currentAmount) / \(habit.goalAmount)")
                .foregroundColor(habit.theme.complementaryColor)
                .padding(.leading, 200)
        )
    }
    
    func calcPercent() -> CGFloat {
        // calculate the width of the bar and what to round it to
        let totalWidth = UIScreen.main.bounds.width - 50
        let percent = CGFloat(habit.currentAmount) / CGFloat(habit.goalAmount)
        let roundedPercent = round(percent * 100) / 100
        let width = totalWidth * roundedPercent
        
        if roundedPercent > 0.95 {
            return totalWidth
        }
        let remainder = width.truncatingRemainder(dividingBy: 1)
        let roundedWidth = remainder > 0.5 ? width + 1 : width
        
        return roundedWidth
    }
}

#Preview {
    TestingView(habit: .constant(Habit.testHabits[0]))
        .environmentObject(AppData())
}
