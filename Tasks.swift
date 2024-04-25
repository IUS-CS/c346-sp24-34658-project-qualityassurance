import Foundation
import SwiftData

enum FrequencyType : String, CaseIterable, Identifiable{
    case daily
    case weekly
    case monthly
    
    var id : String {self.rawValue}
}

@Model
class Tasks {
    var id : UUID = UUID()
    var name : String
    var frequencyType : FrequencyType.RawValue
    var frequency : Int
    var progress : Double
    var imageName : String
    var days : [Int]
    var totalDays : Int
    var totalDaysCompleted : Int
    var notificationId : [String]
    
    init(name: String, frequencyType: FrequencyType.RawValue, frequency: Int, imageName: String, days : [Int]) {
        self.name = name
        self.frequencyType = frequencyType
        self.frequency = frequency
        self.imageName = imageName
        self.days = days
        self.totalDays = 0
        self.totalDaysCompleted = 0
    }


    func updateProgress(){
        self.totalDaysCompleted = totalDaysCompleted + 1
        self.progress = Double(totalDaysCompleted)/Double(totalDays)
    }
}
