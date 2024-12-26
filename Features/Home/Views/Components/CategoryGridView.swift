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
                    color: Color(hex: category.color)
                )
            }
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
                .font(AppTheme.Typography.headline)
                .padding(.top, 8)
        }
    }
} 