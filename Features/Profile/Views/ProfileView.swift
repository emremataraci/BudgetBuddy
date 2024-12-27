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
    @State private var showImagePicker = false
    @State private var profileImage: UIImage?
    
    var body: some View {
        HStack {
            Button(action: {
                showImagePicker = true
            }) {
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(editOverlay)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(AppTheme.Colors.primary)
                        .overlay(editOverlay)
                }
            }
            
            VStack(alignment: .leading) {
                Text(appState.user?.name ?? "")
                    .font(.headline)
                Text(appState.user?.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $profileImage)
        }
    }
    
    private var editOverlay: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.4))
                .frame(width: 30, height: 30)
                .offset(x: 25, y: 25)
            
            Image(systemName: "pencil")
                .foregroundColor(.white)
                .offset(x: 25, y: 25)
        }
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