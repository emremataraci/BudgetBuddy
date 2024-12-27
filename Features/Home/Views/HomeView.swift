import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var appState: AppState
    @State private var showNewTransactionSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: Constants.Layout.padding) {
                        // Header Section
                        VStack(alignment: .leading, spacing: Constants.Layout.padding) {
                            HStack {
                                Text("This month")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppTheme.Colors.text)
                                Spacer()
                                Button(action: viewModel.onSearchTapped) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.title2)
                                        .foregroundColor(AppTheme.Colors.primary)
                                }
                            }
                            .padding(.horizontal)

                            // Spending Summary
                            SpendingSummaryView(amount: viewModel.totalSpending, change: viewModel.spendingChange)
                                .padding(.horizontal)

                            // Category Bars
                            SpendingCategoryBarsView(categories: viewModel.categories)
                                .frame(maxWidth: .infinity)

                            // Balance Summary
                            MonthlyBalanceView(income: viewModel.monthlyIncome, spending: viewModel.totalSpending, balance: viewModel.monthlyBalance)
                                .padding(.horizontal)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: Constants.Layout.cornerRadius)
                                .fill(AppTheme.Colors.background)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)

                        // Categories Grid
                        Text("See your spending by category")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(AppTheme.Colors.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        CategoryGridView(categories: viewModel.categories)
                            .padding(.horizontal)
                    }
                    .padding(.top, Constants.Layout.padding)
                }
                .background(AppTheme.Colors.groupedBackground.ignoresSafeArea())
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                
                // FAB
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showNewTransactionSheet = true
                        }) {
                            Image(systemName: "plus")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(AppTheme.Colors.secondary)
                                .clipShape(Circle())
                                .shadow(color: AppTheme.Colors.secondary.opacity(0.3),
                                       radius: 10, x: 0, y: 5)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .sheet(isPresented: $showNewTransactionSheet) {
            NewTransactionView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}