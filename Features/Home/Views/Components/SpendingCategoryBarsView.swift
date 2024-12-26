import SwiftUI

struct SpendingCategoryBarsView: View {
    let categories: [ExpenseCategory]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(categories) { category in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(category.name)
                            .font(AppTheme.Typography.body)
                            .foregroundColor(AppTheme.Colors.textDark)
                        
                        Spacer()
                        
                        Text("70%") // Dummy progress
                            .font(AppTheme.Typography.caption)
                            .foregroundColor(AppTheme.Colors.primary)
                    }
                    
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppTheme.Colors.primary.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(AppTheme.Colors.primary)
                                    .frame(width: geometry.size.width * 0.7), // Dummy progress
                                alignment: .leading
                            )
                    }
                    .frame(height: 8)
                }
            }
        }
        .padding()
        .background(AppTheme.Colors.background)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
} 