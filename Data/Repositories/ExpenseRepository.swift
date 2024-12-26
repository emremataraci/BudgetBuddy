import CoreData
import Foundation

protocol ExpenseRepositoryProtocol {
    func fetchExpenses() async throws -> [ExpenseModel]
    func addExpense(_ expense: ExpenseModel) async throws
    func deleteExpense(_ expense: ExpenseModel) async throws
    func updateExpense(_ expense: ExpenseModel) async throws
}

class ExpenseRepository: ExpenseRepositoryProtocol {
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchExpenses() async throws -> [ExpenseModel] {
        // TODO: Implement actual CoreData fetch
        return []
    }
    
    func addExpense(_ expense: ExpenseModel) async throws {
        // TODO: Implement actual CoreData save
    }
    
    func deleteExpense(_ expense: ExpenseModel) async throws {
        // TODO: Implement actual CoreData delete
    }
    
    func updateExpense(_ expense: ExpenseModel) async throws {
        // TODO: Implement actual CoreData update
    }
} 