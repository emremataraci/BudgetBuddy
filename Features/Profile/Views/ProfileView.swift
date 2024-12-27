import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showSignOutAlert = false
    
    var body: some View {
        NavigationView {
            List {
                // Profile Header
                Section {
                    ProfileHeaderView()
                }
                .listRowBackground(AppTheme.Colors.background)
                
                // Financial Overview
                Section {
                    FinancialOverviewView(totalSavings: 12450, monthlyBudget: 3200)
                }
                .listRowBackground(AppTheme.Colors.background)
                .listRowInsets(EdgeInsets())
                
                // Account Settings
                Section("Account Settings") {
                    ProfileSettingsItem(
                        title: "Personal Information",
                        icon: "person.circle"
                    )
                    
                    ProfileSettingsItem(
                        title: "Security",
                        icon: "lock"
                    )
                    
                    ProfileSettingsItem(
                        title: "Linked Accounts",
                        icon: "link"
                    )
                }
                .foregroundColor(AppTheme.Colors.text)
                
                // App Settings
                Section("App Settings") {
                    ProfileSettingsItem(
                        title: "Notifications",
                        icon: "bell"
                    )
                    
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(AppTheme.Colors.primary)
                            .frame(width: 24)
                        
                        Text("Dark Mode")
                            .foregroundColor(AppTheme.Colors.text)
                        
                        Spacer()
                        
                        Toggle("", isOn: Binding(
                            get: { appState.isDarkMode },
                            set: { newValue in
                                appState.isDarkMode = newValue
                                NotificationCenter.default.post(name: NSNotification.Name("darkModeChanged"), object: nil)
                            }
                        ))
                        .tint(AppTheme.Colors.secondary)
                    }
                }
                .foregroundColor(AppTheme.Colors.text)
                
                // Support
                Section {
                    Button(action: { showSignOutAlert = true }) {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .background(AppTheme.Colors.groupedBackground)
            .scrollContentBackground(.hidden)
            .alert("Sign Out", isPresented: $showSignOutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Sign Out", role: .destructive) {
                    // TODO: Implement sign out
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
}

struct ProfileHeaderView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showImagePicker = false
    @State private var profileImage: UIImage?
    
    var body: some View {
        HStack(spacing: 16) {
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
            
            VStack(alignment: .leading, spacing: 4) {
                Text(appState.user?.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTheme.Colors.text)
                
                Text(appState.user?.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
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

#Preview {
    ProfileView()
        .environmentObject(AppState())
} 