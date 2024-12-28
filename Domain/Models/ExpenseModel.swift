import Foundation

struct ExpenseModel: Identifiable {
    let id: UUID
    let category: String
    let amount: Double
    let date: Date
    let description: String?
    
    init(id: UUID = UUID(), category: String, amount: Double, date: Date, description: String? = nil) {
        self.id = id
        self.category = category
        self.amount = amount
        self.date = date
        self.description = description
    }
}

struct ExpenseCategory: Identifiable {
    let id: UUID
    let name: String
    let icon: String
    let color: String
    
    static let categories = [
        ExpenseCategory(id: UUID(), name: "Shopping", icon: "cart.fill", color: "D2B48C"),
        ExpenseCategory(id: UUID(), name: "Groceries", icon: "basket.fill", color: "E8D5C4"),
        ExpenseCategory(id: UUID(), name: "Dining", icon: "fork.knife", color: "D2B48C"),
        ExpenseCategory(id: UUID(), name: "Health", icon: "heart.fill", color: "E8D5C4")
    ]
}

struct MonthlyExpense: Identifiable {
    let id: UUID
    let month: String
    let category: String
    let amount: Double
} 