import SwiftUI

struct ProfileSettingsItem: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    init(
        title: String,
        icon: String,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(AppTheme.Colors.primary)
                    .frame(width: 24)
                
                Text(title)
                    .foregroundColor(AppTheme.Colors.textDark)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
    }
} 