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
    @Published var isDarkMode: Bool = false
    
    init() {
        // TODO: Load user data
        self.user = UserModel(name: "Emre Mataracı", email: "emre@example.com")
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
