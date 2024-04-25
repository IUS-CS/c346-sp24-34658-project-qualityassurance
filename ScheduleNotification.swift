import Foundation
import UIKit

class AppDelegate : UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    var notificationManager = NotificationManager.shared
    
    func applicaton(_application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) {
            granted, error in
            if granted {
                print("Notification permission granted")
            }else {
                print("Notification permission denied")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler : @escaping ()-> Void){
        let notificationId = response.notification.request.identifier.prefix(36)
        notificationManager.handleNotification(notification:response.notification, id: String(notificationId))
             
             completionHandler()
    }
}
class Notification {
    func addNotification(content : UNMutableNotificationContent, dateComponents : DateComponents, id: String) {
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request){error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func scheduleNotification(task : Tasks, time : Date) -> Tasks {
        var count = 0
        var notificationId : [String] = []
        let content = UNMutableNotificationContent()
        content.title = "Reminder : Habit Tracker"
        content.body = task.name
        content.sound = UNNotificationSound.default
        
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year,.month,.day], from: date)
        let components = calendar.dateComponents([.hour,.minute], from: time)
        
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        dateComponents.second = 00
        
        for day in task.days {
            if task.frequencyType == FrequencyType.daily.rawValue {
                dateComponents.weekday = day
                if (task.frequency > task.days.count){
                    for dayCount in 0..<task.frequency{
                        let scheduledDate = calendar.date(byAdding: .day, value: dayCount, to: date)!
                        
                        let details = calendar.dateComponents([.year,.month,.day,.weekday], from: scheduledDate)
                        if details.weekday == day {
                            dateComponents.day = details.day
                            dateComponents.month = details.month
                            dateComponents.year = details.year
                            
                            addNotification(content: content, dateComponents: dateComponents, id: task.id.uuidString+"\(day)\(dayCount)")
                            notificationId.append(task.id.uuidString+"\(day)\(dayCount)")
                            count += 1
                        }
                    }
                }
                else{
                    
                    dateComponents.weekday = day
                    addNotification(content: content, dateComponents: dateComponents, id: task.id.uuidString+"\(day)")
                    notificationId.append(task.id.uuidString+"\(day)")
                    count += 1
                }
            }
                else if task.frequencyType == FrequencyType.weekly.rawValue{
                        dateComponents.weekday = day
                        for dayCount in 0..<task.frequency*7{
                            let scheduledDate = calendar.date(byAdding: .day, value: dayCount, to: date)!
                            
                            let details = calendar.dateComponents([.year,.month,.day,.weekday], from: scheduledDate)
                            if details.weekday == day {
                                dateComponents.day = details.day
                                dateComponents.month = details.month
                                dateComponents.year = details.year
                                
                                addNotification(content: content, dateComponents: dateComponents, id: task.id.uuidString+"\(day)\(dayCount)")
                                notificationId.append(task.id.uuidString+"\(day)\(dayCount)")
                                
                                count += 1
                        }
                    }
                }
            else {
                dateComponents.day = day
                for i in 0..<task.frequency{
                    dateComponents.month = dateComponents.month! + i
                    
                    addNotification(content: content, dateComponents: dateComponents, id: task.id.uuidString+"\(day)\(i)")
                    notificationId.append(task.id.uuidString+"\(day)\(i)")
                    
                    count+=1
                    
                    }
                }
            }
            task.frequency = count
            task.notificationId = notificationId
            return task
        }
    func deletePendingNotification(id: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: id)
    }
    
}

