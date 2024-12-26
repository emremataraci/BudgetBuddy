import Foundation

struct GoalModel: Identifiable {
    let id: UUID
    let title: String
    let targetAmount: Double
    let currentAmount: Double
    let deadline: Date?
    let category: String
    
    var progress: Double {
        currentAmount / targetAmount
    }
    
    init(id: UUID = UUID(), title: String, targetAmount: Double, currentAmount: Double, deadline: Date? = nil, category: String) {
        self.id = id
        self.title = title
        self.targetAmount = targetAmount
        self.currentAmount = currentAmount
        self.deadline = deadline
        self.category = category
    }
}

struct GoalCategory: Identifiable {
    let id: UUID
    let name: String
    let icon: String
    
    static let categories = [
        GoalCategory(id: UUID(), name: "Car", icon: "car.fill"),
        GoalCategory(id: UUID(), name: "Vacation", icon: "airplane"),
        GoalCategory(id: UUID(), name: "Emergency", icon: "shield.fill"),
        GoalCategory(id: UUID(), name: "Education", icon: "book.fill")
    ]
} 