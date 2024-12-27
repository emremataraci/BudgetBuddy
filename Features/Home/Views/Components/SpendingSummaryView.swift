import SwiftUI

struct SpendingSummaryView: View {
    let amount: Double
    let change: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Spending")
                .font(AppTheme.Typography.title3)
                .foregroundColor(AppTheme.Colors.textSecondary)
            
            Text(amount.formatAsCurrency())
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(AppTheme.Colors.text)
            
            HStack {
                Text("Last 30 Days")
                    .foregroundColor(AppTheme.Colors.textSecondary)
                Text(change.formatAsPercentage())
                    .foregroundColor(change >= 0 ? AppTheme.Colors.secondary : AppTheme.Colors.error)
            }
            .font(AppTheme.Typography.caption)
        }
        .padding()
        .background(AppTheme.Colors.background)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
}

// MARK: - Preview
struct SpendingSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingSummaryView(amount: 3000, change: 12)
            .padding()
            .background(AppTheme.Colors.groupedBackground)
    }
}

// MARK: - Helpers
extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Constants.Currency.locale
        return formatter.string(from: NSNumber(value: self)) ?? "\(Constants.Currency.symbol)\(self)"
    }
    
    func formatAsPercentage() -> String {
        let prefix = self >= 0 ? "+" : ""
        return "\(prefix)\(Int(self))%"
    }
} 