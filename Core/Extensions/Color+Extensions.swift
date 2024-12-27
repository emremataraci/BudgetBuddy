import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    // Brand Colors
    static let brandPrimary = Color(hex: "1E90FF")    // Dodger Blue
    static let brandSuccess = Color(hex: "32CD32")    // Lime Green
    static let brandWarning = Color(hex: "FFA500")    // Orange
    
    // Semantic Colors
    static let appPrimary = brandPrimary
    static let appSecondary = brandSuccess
    static let appAccent = brandWarning
    static let appBackground = Color(light: Color(hex: "F5F5F5"), dark: Color(hex: "1C1C1E"))
    static let appGroupedBackground = Color(light: Color(hex: "F5F5F5").opacity(0.95), dark: Color(hex: "1C1C1E").opacity(0.95))
    static let appText = Color(light: Color(hex: "696969"), dark: .white)
    static let appTextSecondary = Color(light: Color(hex: "696969").opacity(0.7), dark: Color.white.opacity(0.7))
    static let appTextDark = Color(light: .black, dark: .white)
}

extension Color {
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
    }
} 