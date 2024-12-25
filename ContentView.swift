//
//  ContentView.swift
//  BudgetBuddy
//
//  Created by EMRE MATARACI on 25.12.2024.
//

import SwiftUI
import CoreData
import Charts

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            GoalsView()
                .tabItem {
                    Label("Goals", systemImage: "target")
                }
            
            ExpensesView()
                .tabItem {
                    Label("Expenses", systemImage: "creditcard.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

// MARK: - Home View
struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("This month")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.primary)
                                    .font(.title2)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Spending")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            
                            Text("$3,000")
                                .font(.system(size: 40, weight: .bold))
                            
                            HStack {
                                Text("Last 30 Days")
                                    .foregroundColor(.secondary)
                                Text("+12%")
                                    .foregroundColor(.green)
                            }
                            .font(.subheadline)
                        }
                        
                        SpendingCategoryBarsView()
                        MonthlyBalanceView()
                    }
                    .padding()
                    
                    Text("See your spending by category")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    CategoryGridView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Supporting Views for Home
struct SpendingCategoryBarsView: View {
    let categories = [
        ("Shopping", 0.8),
        ("Groceries", 0.7),
        ("Dining", 0.6),
        ("Health", 0.3)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(categories, id: \.0) { category, progress in
                VStack(alignment: .leading, spacing: 4) {
                    Text(category)
                        .foregroundColor(.secondary)
                    
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.systemGray5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.blue)
                                    .frame(width: geometry.size.width * progress),
                                alignment: .leading
                            )
                    }
                    .frame(height: 8)
                }
            }
        }
        .padding(.vertical)
    }
}

struct MonthlyBalanceView: View {
    var body: some View {
        VStack(spacing: 16) {
            BalanceRow(title: "Income", amount: "$4,000")
            BalanceRow(title: "Spending", amount: "$3,000")
            BalanceRow(title: "Balance", amount: "$1,000")
        }
        .padding(.top)
    }
}

struct BalanceRow: View {
    let title: String
    let amount: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(.secondary)
            Spacer()
            Text(amount)
                .font(.body)
                .fontWeight(.medium)
        }
    }
}

struct CategoryGridView: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            CategoryCard(title: "Shopping", imageName: "cart.fill", color: Color(hex: "D2B48C"))
            CategoryCard(title: "Groceries", imageName: "basket.fill", color: Color(hex: "E8D5C4"))
            CategoryCard(title: "Dining", imageName: "fork.knife", color: Color(hex: "D2B48C"))
            CategoryCard(title: "Health", imageName: "heart.fill", color: Color(hex: "E8D5C4"))
        }
        .padding()
    }
}

struct CategoryCard: View {
    let title: String
    let imageName: String
    let color: Color
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .frame(height: 120)
                .overlay(
                    Image(systemName: imageName)
                        .font(.system(size: 30))
                        .foregroundColor(.black.opacity(0.7))
                )
            
            Text(title)
                .font(.headline)
                .padding(.top, 8)
        }
    }
}

// MARK: - Helper Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Goals View
struct GoalsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<3) { index in
                        GoalCardView(
                            title: ["New Car", "Vacation", "Emergency Fund"][index],
                            current: [60000, 3000, 8000][index],
                            target: [100000, 5000, 10000][index]
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Goals")
        }
    }
}

// MARK: - Expenses View
struct ExpensesView: View {
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

// MARK: - Profile View
struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    ProfileHeaderView()
                }
                
                Section("Settings") {
                    SettingsItemView(title: "Account Info", icon: "person.circle")
                    SettingsItemView(title: "Notifications", icon: "bell")
                    SettingsItemView(title: "Theme", icon: "paintbrush")
                    SettingsItemView(title: "Help", icon: "questionmark.circle")
                }
            }
            .navigationTitle("Profile")
        }
    }
}

// MARK: - Supporting Views
struct BudgetCardView: View {
    var body: some View {
        VStack {
            Text("Toplam Bütçe")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("₺4,250")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.primary)
            
            HStack {
                Text("Bu ay")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("+₺1,200")
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding()
    }
}

struct GoalCardView: View {
    let title: String
    let current: Double
    let target: Double
    
    var progress: Double {
        current / target
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            ProgressView(value: progress)
                .tint(.blue)
            
            HStack {
                Text("$\(Int(current)) / $\(Int(target))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct ExpenseSummaryView: View {
    var body: some View {
        VStack {
            Text("Aylık Özet")
                .font(.headline)
            
            // Burada gerçek bir grafik komponenti eklenebilir
            Rectangle()
                .fill(Color.blue.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    Text("Grafik Gösterimi")
                        .foregroundColor(.blue)
                )
        }
        .padding()
    }
}

struct SettingsItemView: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
        }
    }
}

struct ProfileHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text("Emre Mataracı")
                    .font(.headline)
                Text("emre@example.com")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical)
    }
}

struct RecentExpensesListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Son Harcamalar")
                .font(.headline)
                .padding(.horizontal)
            
            List {
                ForEach(0..<5) { _ in
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: "cart.fill")
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment: .leading) {
                            Text("Market Alışverişi")
                                .font(.subheadline)
                            Text("Migros")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("-₺245")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct ExpenseListView: View {
    var body: some View {
        List {
            ForEach(0..<10) { _ in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Market Alışverişi")
                            .font(.subheadline)
                        Text("12 Ocak 2024")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("-₺245")
                        .foregroundColor(.red)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
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
