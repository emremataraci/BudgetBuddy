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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
