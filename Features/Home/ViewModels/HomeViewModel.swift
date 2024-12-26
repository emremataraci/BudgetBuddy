import Foundation

class HomeViewModel: ObservableObject {
    @Published var totalSpending: Double = 3000
    @Published var spendingChange: Double = 12
    @Published var monthlyIncome: Double = 4000
    @Published var categories: [ExpenseCategory] = ExpenseCategory.categories
    
    var monthlyBalance: Double {
        monthlyIncome - totalSpending
    }
    
    func onSearchTapped() {
        // TODO: Implement search functionality
    }
    
    func fetchData() {
        // TODO: Implement data fetching from repository
    }
} 