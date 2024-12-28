import Foundation

class HomeViewModel: ObservableObject {
    @Published var totalBalance: Double = 24562.80
    @Published var totalIncome: Double = 32145
    @Published var totalExpenses: Double = 7582
    @Published var monthlySpending: Double = 2458.50
    @Published var monthlySpendingChange: Double = 15.3
    @Published var categories: [ExpenseCategory] = ExpenseCategory.categories
    
    var recentTransactions: [(title: String, date: String, amount: String, isExpense: Bool, icon: String)] = [
        ("Shopping", "Today, 2:35 PM", "-$85.00", true, "cart.fill"),
        ("Salary", "Mar 1, 2025", "+$4,250.00", false, "dollarsign.circle.fill")
    ]
    
    func fetchData() {
        // TODO: Implement data fetching from repository
    }
} 