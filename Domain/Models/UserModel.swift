import Foundation

struct UserModel: Identifiable {
    let id: UUID
    var name: String
    var email: String
    var monthlyBudget: Double?
    var currency: String
    var profileImage: String?
    
    init(id: UUID = UUID(), name: String, email: String, monthlyBudget: Double? = nil, currency: String = "USD", profileImage: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.monthlyBudget = monthlyBudget
        self.currency = currency
        self.profileImage = profileImage
    }
} 