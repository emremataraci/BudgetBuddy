import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ProfileHeaderView()
                }
                
                Section("Settings") {
                    SettingsItemView(title: "Account Info", icon: "person.circle")
                    SettingsItemView(title: "Notifications", icon: "bell")
                    SettingsItemView(title: "Theme", icon: "paintbrush")
                    SettingsItemView(title: "Help", icon: "questionmark.circle")
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileHeaderView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text(appState.user?.name ?? "")
                    .font(.headline)
                Text(appState.user?.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical)
    }
}

struct SettingsItemView: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
} 