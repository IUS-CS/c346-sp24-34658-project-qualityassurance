

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            IntroductionScreenView(title: "Welcome", description: "Welcome to Habit Tracker App", imageName: "Welcome", isLastPage: false)
            
            IntroductionScreenView(title: "Set the Goals", description: "Choose the duration between a Week or upto 2 Months to adjust to new Goal ", imageName: "timeManager", isLastPage: false)
            
            IntroductionScreenView(title: "Kill the Bad Habits ", description: "Get rid of all the bad habits", imageName: "badHabits", isLastPage: false)
            
            IntroductionScreenView(title: "Gain Success using Consistency", description: "Consistent habits are powerful tools for achieving long-term goals", imageName: "Suceess", isLastPage: true)
            
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
    }
}

struct IntroductionScreenView : View {
    let title : String
    let description : String
    let imageName : String
    let isLastPage : Bool
    @State private var isSheetPresented = false
    
    var body : some View {
        VStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if isLastPage {
                Button(action: {
                    isSheetPresented = true
                    
                }){
                    Text("Get Started")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .shadow(color:Color.black.opacity(0.3),radius: 5,x: 0, y: 3)
                }
                .padding(.top,100)
                
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isSheetPresented, content: {
            LandingScreen()
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
        })
    }
}
