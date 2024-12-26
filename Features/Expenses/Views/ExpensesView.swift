import SwiftUI
import Charts

struct ExpensesView: View {
    @EnvironmentObject private var appState: AppState
    
    let expenseData: [ExpenseData] = [
        // Shopping Data
        ExpenseData(category: "Shopping", month: "Jan", amount: 450),
        ExpenseData(category: "Shopping", month: "Feb", amount: 380),
        ExpenseData(category: "Shopping", month: "Mar", amount: 630),
        ExpenseData(category: "Shopping", month: "Apr", amount: 520),
        
        // Groceries Data
        ExpenseData(category: "Groceries", month: "Jan", amount: 320),
        ExpenseData(category: "Groceries", month: "Feb", amount: 340),
        ExpenseData(category: "Groceries", month: "Mar", amount: 280),
        ExpenseData(category: "Groceries", month: "Apr", amount: 360),
        
        // Dining Data
        ExpenseData(category: "Dining", month: "Jan", amount: 280),
        ExpenseData(category: "Dining", month: "Feb", amount: 320),
        ExpenseData(category: "Dining", month: "Mar", amount: 350),
        ExpenseData(category: "Dining", month: "Apr", amount: 290),
        
        // Health Data
        ExpenseData(category: "Health", month: "Jan", amount: 150),
        ExpenseData(category: "Health", month: "Feb", amount: 100),
        ExpenseData(category: "Health", month: "Mar", amount: 200),
        ExpenseData(category: "Health", month: "Apr", amount: 180)
    ]
    
    var categoryTotals: [CategoryTotal] {
        Dictionary(grouping: expenseData) { $0.category }
            .map { category, expenses in
                CategoryTotal(category: category, total: expenses.reduce(0) { $0 + $1.amount })
            }
            .sorted { $0.total > $1.total }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Monthly Trend Chart
                    VStack(alignment: .leading) {
                        Text("Monthly Trends")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        Chart {
                            ForEach(expenseData) { item in
                                LineMark(
                                    x: .value("Month", item.month),
                                    y: .value("Amount", item.amount)
                                )
                                .foregroundStyle(by: .value("Category", item.category))
                            }
                        }
                        .frame(height: 200)
                        .padding()
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding()
                    
                    // Category Distribution Chart
                    VStack(alignment: .leading) {
                        Text("Category Distribution")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        Chart(categoryTotals) { category in
                            SectorMark(
                                angle: .value("Total", category.total),
                                innerRadius: .ratio(0.618)
                            )
                            .foregroundStyle(by: .value("Category", category.category))
                        }
                        .frame(height: 200)
                        .padding()
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding()
                    
                    // Recent Transactions
                    VStack(alignment: .leading) {
                        Text("Recent Transactions")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        ForEach(expenseData.prefix(5)) { expense in
                            HStack {
                                Circle()
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Image(systemName: categoryIcon(for: expense.category))
                                            .foregroundColor(.blue)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(expense.category)
                                        .font(.headline)
                                    Text(expense.month)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("$\(String(format: "%.2f", expense.amount))")
                                    .foregroundColor(.red)
                                    .font(.headline)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding()
                }
            }
            .navigationTitle("Expenses")
            .background(Color(.systemGroupedBackground))
        }
    }
    
    func categoryIcon(for category: String) -> String {
        switch category {
        case "Shopping": return "cart.fill"
        case "Groceries": return "basket.fill"
        case "Dining": return "fork.knife"
        case "Health": return "heart.fill"
        default: return "dollarsign.circle.fill"
        }
    }
}

#Preview {
    ExpensesView()
        .environmentObject(AppState())
}

// MARK: - Models
struct ExpenseData: Identifiable {
    let id = UUID()
    let category: String
    let month: String
    let amount: Double
}

struct CategoryTotal: Identifiable {
    let id = UUID()
    let category: String
    let total: Double
} 