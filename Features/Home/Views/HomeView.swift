import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showNewTransactionSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Section
                    HStack {
                        HStack(spacing: 12) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                            
                            VStack(alignment: .leading) {
                                Text("Welcome back,")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Alex Morgan")
                                    .font(.headline)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Balance Card
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Total Balance")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                            Text("$24,562.80")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Income")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                Text("$32,145")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Expenses")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                Text("$7,582")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Action Buttons
                    HStack(spacing: 20) {
                        ActionButton(title: "Income", icon: "arrow.down", color: .blue, bgColor: Color.green.opacity(0.2))
                        ActionButton(title: "Expense", icon: "arrow.up", color: .red, bgColor: Color.red.opacity(0.2))
                        ActionButton(title: "Budget", icon: "clock", color: .purple, bgColor: Color.purple.opacity(0.2))
                    }
                    .padding(.horizontal)
                    
                    // Spending Overview
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("This Month")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("$2,458.50")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            Text("+15.3%")
                                .foregroundColor(.green)
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        Text("vs last month")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        
                        // Category Bars
                        VStack(spacing: 16) {
                            SpendingCategoryRow(
                                icon: "house.fill",
                                title: "Housing",
                                amount: "$1,200",
                                color: .blue,
                                showProgressBar: true,
                                progress: 0.8
                            )
                            
                            SpendingCategoryRow(
                                icon: "fork.knife",
                                title: "Food",
                                amount: "$485",
                                color: .green,
                                showProgressBar: true,
                                progress: 0.4
                            )
                            
                            SpendingCategoryRow(
                                icon: "car.fill",
                                title: "Transport",
                                amount: "$350",
                                color: .purple,
                                showProgressBar: true,
                                progress: 0.3
                            )
                        }
                    }
                    .padding()
                    
                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Transactions")
                                .font(.headline)
                            Spacer()
                            Button("See All") {
                                // Action
                            }
                            .foregroundColor(.blue)
                        }
                        
                        VStack(spacing: 16) {
                            TransactionRow(
                                title: "Shopping",
                                date: "Today, 2:35 PM",
                                amount: "-$85.00",
                                isExpense: true,
                                icon: "cart.fill",
                                iconBgColor: .red.opacity(0.2),
                                iconColor: .red
                            )
                            
                            TransactionRow(
                                title: "Salary",
                                date: "Mar 1, 2025",
                                amount: "+$4,250.00",
                                isExpense: false,
                                icon: "dollarsign.circle.fill",
                                iconBgColor: .green.opacity(0.2),
                                iconColor: .green
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showNewTransactionSheet) {
            NewTransactionView()
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let bgColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(bgColor)
                .frame(width: 55, height: 55)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(color)
                )
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct SpendingCategoryRow: View {
    let icon: String
    let title: String
    let amount: String
    let color: Color
    let showProgressBar: Bool
    let progress: CGFloat
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 22, weight: .semibold))
                .frame(width: 40, height: 40)
                .background(color.opacity(0.15))
                .clipShape(Circle())
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(amount)
                    .font(.headline)
                
                if showProgressBar {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(color.opacity(0.15))
                                .frame(width: geometry.size.width, height: 4)
                            
                            Rectangle()
                                .fill(color)
                                .frame(width: geometry.size.width * progress, height: 4)
                        }
                    }
                    .frame(width: 100, height: 4)
                }
            }
        }
        .frame(height: 50)
    }
}

struct TransactionRow: View {
    let title: String
    let date: String
    let amount: String
    let isExpense: Bool
    let icon: String
    let iconBgColor: Color
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(iconBgColor)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(amount)
                .font(.headline)
                .foregroundColor(isExpense ? .red : .green)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}