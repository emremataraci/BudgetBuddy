import SwiftUI

struct FinancialOverviewView: View {
    let totalSavings: Double
    let monthlyBudget: Double
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Financial Overview")
                .font(.headline)
                .foregroundColor(AppTheme.Colors.textDark)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 12) {
                // Total Savings Card
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Savings")
                        .font(AppTheme.Typography.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                    
                    Text(totalSavings.formatAsCurrency())
                        .font(AppTheme.Typography.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "0066CC"))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppTheme.Colors.primary.opacity(0.1))
                .cornerRadius(12)
                
                // Monthly Budget Card
                VStack(alignment: .leading, spacing: 4) {
                    Text("Monthly Budget")
                        .font(AppTheme.Typography.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                    
                    Text(monthlyBudget.formatAsCurrency())
                        .font(AppTheme.Typography.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "2AAA2A"))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppTheme.Colors.secondary.opacity(0.1))
                .cornerRadius(12)
            }
        }
        .padding()
        .background(AppTheme.Colors.background)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
} 