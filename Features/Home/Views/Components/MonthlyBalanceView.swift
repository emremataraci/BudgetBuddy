import SwiftUI

struct MonthlyBalanceView: View {
    let income: Double
    let spending: Double
    let balance: Double
    
    var body: some View {
        VStack(spacing: 16) {
            BalanceRow(title: "Income", amount: income.formatAsCurrency())
            BalanceRow(title: "Spending", amount: spending.formatAsCurrency())
            BalanceRow(title: "Balance", amount: balance.formatAsCurrency())
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
                .font(AppTheme.Typography.body)
                .foregroundColor(.secondary)
            Spacer()
            Text(amount)
                .font(AppTheme.Typography.body)
                .fontWeight(.medium)
        }
    }
} 