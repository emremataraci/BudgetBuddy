import SwiftUI

struct MonthlyBalanceView: View {
    let income: Double
    let spending: Double
    let balance: Double
    
    var body: some View {
        VStack(spacing: 16) {
            BalanceRow(title: "Income", amount: income.formatAsCurrency(), amountColor: AppTheme.Colors.secondary)
            BalanceRow(title: "Spending", amount: spending.formatAsCurrency(), amountColor: AppTheme.Colors.error)
            BalanceRow(title: "Balance", amount: balance.formatAsCurrency(), amountColor: AppTheme.Colors.primary)
        }
        .padding()
        .background(AppTheme.Colors.background)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
}

struct BalanceRow: View {
    let title: String
    let amount: String
    let amountColor: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(AppTheme.Typography.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
            Spacer()
            Text(amount)
                .font(AppTheme.Typography.body)
                .fontWeight(.medium)
                .foregroundColor(amountColor)
        }
    }
} 