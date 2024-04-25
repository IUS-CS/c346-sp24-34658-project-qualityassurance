
import SwiftUI
import SwiftData

struct ProgressBar:  View {
    var task : Tasks
    @State private var progress: CGFloat = 0.0
    @State var finalProgress : CGFloat
    var imageName : String
    var name : String
    var total : Int
    var completed : Int
    var durationName : String
    var action : (Tasks) -> Void
    @State private var displayDeletionAlert = false
    
    
    
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    Image(imageName)
                        .resizable()
                        .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.white)
                    Text("Completed \(completed) of \(total) \n \(durationName) task")
                        .foregroundColor(.white)
                        .font(.system(size: 9))
                        .multilineTextAlignment(.center)
                    
                }
                Circle ()
                    .stroke(Color.gray,lineWidth: 10)
                
                Circle()
                    .trim(from : 0, to: CGFloat(min(1,progress)))
                    .stroke(AngularGradient(gradient: Gradient(colors: [.white]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                                            ,startAngle: .degrees(0), endAngle: .degrees(360*progress)), lineWidth: 10)
                    .rotationEffect(.degrees(-90))
            }
            Text(name)
                .bold()
                .foregroundStyle(.white)
        }
        .padding()
        .frame(width: 150, height: 200)
        
        .onAppear{
            finalProgress = Double (completed)/Double(total)
                updateProgress(finalProgress)
            
        }
        .gesture(LongPressGesture(minimumDuration: 2)
            .onEnded{ _ in
                displayDeletionAlert = true
            })
        .alert(isPresented: $displayDeletionAlert){
            Alert(
                title: Text("Delete Task"), message: Text("Do you really want to delete this task ?"), primaryButton: .default(Text("OK"), action: {
                self.action(task)
            }),
            secondaryButton : .cancel(Text("Cancel"), action : {
                print("Cancel Tapped")
                
            })
            
        )
        }
    }
    func updateProgress(_ fprogress: Double) {
        print("updateProgress called with \(fprogress)")
        withAnimation(.easeInOut(duration: 2.0)){
            self.progress = fprogress
        }
    }
}

struct LandingScreen: View {
    @Environment (\.modelContext) private var modelContext
    let columns : [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @Query var tasks : [Tasks]
    @State var isPresentingFullSreen : Bool = false
    @State var string : String = ""
    var body: some View {
        ScrollView{
            Text(string)
            LazyVGrid(columns: columns, spacing: 20){
                ForEach(tasks.indices, id: \.self){ index in ProgressBar(task: tasks[index], finalProgress: tasks[index].progress, imageName: tasks[index].imageName, name: tasks[index].name, total: tasks[index].totalDays, completed: tasks[index].totalDaysCompleted, durationName: tasks[index].frequencyType, action: { t in
                    
                    deleteATask(task: t)
                    
                    })
                    
                    }
                Button(action: {
                    isPresentingFullSreen = true
                    
                }){
                    VStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.white)
                        
                        Text("Add new Task")
                            .bold()
                            .foregroundStyle(.white)
                    }
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                    if let notification = NotificationManager.shared.receivedNotification{
                        let id = NotificationManager.shared.notificationID
                        
                        for task in tasks {
                            if(task.id.uuidString == id) {
                                if(task.progress<1.0){
                                    task.updateProgress()
                                }
                                
                                modelContext.insert(task)
                            }
                        }
                    }
                    
                }
            }
        }.background(Color.purple)
            .fullScreenCover(isPresented: $isPresentingFullSreen, content: {
                TaskCreationView(displayTaskCreationView: $isPresentingFullSreen)
            })
    }
    
    func deleteATask(task: Tasks){
        Notification().deletePendingNotification(id: task.notificationId)
        modelContext.delete(object: task)
    }
}

