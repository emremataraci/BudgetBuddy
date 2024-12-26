import SwiftUI

struct SpendingCategoryBarsView: View {
    let categories: [ExpenseCategory]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(categories) { category in
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.name)
                        .foregroundColor(.secondary)
                    
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.systemGray5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(hex: category.color))
                                    .frame(width: geometry.size.width * 0.7), // Dummy progress
                                alignment: .leading
                            )
                    }
                    .frame(height: 8)
                }
            }
        }
        .padding(.vertical)
    }
} 