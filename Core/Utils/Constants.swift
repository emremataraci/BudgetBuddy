import Foundation

enum Constants {
    enum App {
        static let name = "BudgetBuddy"
        static let version = "1.0.0"
    }
    
    enum DateFormat {
        static let shortDate = "MMM d"
        static let monthYear = "MMMM yyyy"
        static let fullDate = "MMM d, yyyy"
    }
    
    enum Currency {
        static let symbol = "$"
        static let code = "USD"
        static let locale = Locale(identifier: "en_US")
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 16
        static let iconSize: CGFloat = 24
    }
} 