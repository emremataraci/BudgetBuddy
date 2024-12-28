import Foundation

struct GoalModel: Identifiable {
    let id: UUID
    let title: String
    let targetAmount: Double
    let currentAmount: Double
    let deadline: Date
    let status: GoalStatus
    
    var progress: Double {
        currentAmount / targetAmount
    }
    
    init(id: UUID = UUID(), title: String, targetAmount: Double, currentAmount: Double, deadline: Date, status: GoalStatus = .onTrack) {
        self.id = id
        self.title = title
        self.targetAmount = targetAmount
        self.currentAmount = currentAmount
        self.deadline = deadline
        self.status = status
    }
}

enum GoalStatus {
    case onTrack
    case almostThere
    case behindSchedule
} 