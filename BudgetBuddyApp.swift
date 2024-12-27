//
//  BudgetBuddyApp.swift
//  BudgetBuddy
//
//  Created by EMRE MATARACI on 25.12.2024.
//

import SwiftUI

@main
struct BudgetBuddyApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var appState = AppState()
    @StateObject private var appConfiguration = AppConfiguration.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appState)
                .preferredColorScheme(appState.isDarkMode ? .dark : .light)
        }
    }
}

// Main application state
class AppState: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var user: UserModel?
    @Published var isDarkMode: Bool {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
        }
    }
    
    init() {
        // Load dark mode preference
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        // TODO: Load user data
        self.user = UserModel(name: "Emre Mataracı", email: "emre@example.com")
        
        // Add observer for dark mode changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(darkModeChanged),
            name: NSNotification.Name("darkModeChanged"),
            object: nil
        )
    }
    
    @objc private func darkModeChanged() {
        objectWillChange.send()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// App configuration and environment setup
class AppConfiguration: ObservableObject {
    static let shared = AppConfiguration()
    let persistenceController = PersistenceController.shared
    
    private init() {}
    
    func setupEnvironment() {
        // TODO: Setup any required environment configurations
    }
}
