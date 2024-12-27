import SwiftUI

enum AppTheme {
    enum Typography {
        static let title = Font.title.bold()
        static let title2 = Font.title2.bold()
        static let title3 = Font.title3.bold()
        static let headline = Font.headline
        static let body = Font.body
        static let caption = Font.caption
    }
    
    enum Colors {
        // Primary Colors
        static let primary = Color.brandPrimary
        static let secondary = Color.brandSuccess
        static let accent = Color.brandWarning
        
        // Background Colors
        static let background = Color.appBackground
        static let groupedBackground = Color.appGroupedBackground
        
        // Text Colors
        static let text = Color.appText
        static let textSecondary = Color.appTextSecondary
        static let textDark = Color.appTextDark
        
        // Status Colors
        static let success = Color.brandSuccess
        static let error = Color.brandWarning
        static let warning = Color.brandWarning.opacity(0.8)
    }
    
    enum Shadows {
        static let small = Shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
        static let medium = Shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 4)
        static let large = Shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
    }
}

struct Shadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
} 