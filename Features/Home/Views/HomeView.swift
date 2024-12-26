import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Layout.padding) {
                    // Header
                    VStack(alignment: .leading, spacing: Constants.Layout.padding) {
                        HStack {
                            Text("This month")
                                .font(AppTheme.Typography.title)
                            
                            Spacer()
                            
                            Button(action: viewModel.onSearchTapped) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.primary)
                                    .font(.title2)
                            }
                        }
                        
                        // Spending Summary
                        SpendingSummaryView(
                            amount: viewModel.totalSpending,
                            change: viewModel.spendingChange
                        )
                        
                        // Category Bars
                        SpendingCategoryBarsView(categories: viewModel.categories)
                        
                        // Balance Summary
                        MonthlyBalanceView(
                            income: viewModel.monthlyIncome,
                            spending: viewModel.totalSpending,
                            balance: viewModel.monthlyBalance
                        )
                    }
                    .padding()
                    
                    // Categories Grid
                    Text("See your spending by category")
                        .font(AppTheme.Typography.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    CategoryGridView(categories: viewModel.categories)
                }
            }
            .navigationBarHidden(true)
            .background(AppTheme.Colors.groupedBackground)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
} 