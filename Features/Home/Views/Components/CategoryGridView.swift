import SwiftUI

struct CategoryGridView: View {
    let categories: [ExpenseCategory]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            ForEach(categories) { category in
                CategoryCard(
                    title: category.name,
                    imageName: category.icon,
                    amount: "$450" // Dummy amount
                )
            }
        }
        .padding()
        .background(AppTheme.Colors.background)
        .cornerRadius(Constants.Layout.cornerRadius)
    }
}

struct CategoryCard: View {
    let title: String
    let imageName: String
    let amount: String
    
    var body: some View {
        VStack(spacing: 12) {
            // Icon Circle
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.primary.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: imageName)
                    .font(.system(size: 24))
                    .foregroundColor(AppTheme.Colors.primary)
            }
            
            VStack(spacing: 4) {
                Text(title)
                    .font(AppTheme.Typography.headline)
                    .foregroundColor(AppTheme.Colors.textDark)
                
                Text(amount)
                    .font(AppTheme.Typography.body)
                    .foregroundColor(AppTheme.Colors.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.Colors.background)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
} 