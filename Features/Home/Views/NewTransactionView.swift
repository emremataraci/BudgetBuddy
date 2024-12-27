import SwiftUI

struct NewTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var transactionType = "expense"
    @State private var amount = ""
    @State private var category = "Daily Expenses"
    @State private var note = ""
    @State private var date = Date()
    
    // Expense Categories
    private let expenseCategories = [
        "Other Expenses",
        "Personal",
        "Bills",
        "Daily Expenses"
    ]
    
    // Income Categories
    private let incomeCategories = [
        "Other Income",
        "Investments",
        "Business",
        "Regular Income"
    ]
    
    private var currentCategories: [String] {
        transactionType == "expense" ? expenseCategories : incomeCategories
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Header with close button
            HStack {
                Text("Add Transaction")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            
            // Transaction Type
            VStack(alignment: .leading, spacing: 12) {
                Text("Transaction Type")
                    .font(.headline)
                    .foregroundColor(AppTheme.Colors.textDark)
                
                HStack(spacing: 16) {
                    TransactionTypeButton(
                        title: "Expense",
                        icon: "arrow.up",
                        isSelected: transactionType == "expense",
                        color: AppTheme.Colors.accent,
                        action: { 
                            transactionType = "expense"
                            category = expenseCategories[0]
                        }
                    )
                    
                    TransactionTypeButton(
                        title: "Income",
                        icon: "arrow.down",
                        isSelected: transactionType == "income",
                        color: AppTheme.Colors.secondary,
                        action: { 
                            transactionType = "income"
                            category = "Regular Income"
                        }
                    )
                }
            }
            
            // Amount
            VStack(alignment: .leading, spacing: 12) {
                Text("Amount")
                    .font(.headline)
                    .foregroundColor(AppTheme.Colors.textDark)
                
                HStack {
                    Text("$")
                        .foregroundColor(AppTheme.Colors.textSecondary)
                    TextField("0.00", text: $amount)
                        .keyboardType(.decimalPad)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
            }
            
            // Date
            VStack(alignment: .leading, spacing: 12) {
                Text("Date")
                    .font(.headline)
                    .foregroundColor(AppTheme.Colors.textDark)
                
                DatePicker("", selection: $date, displayedComponents: [.date])
                    .labelsHidden()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
            }
            
            // Category
            VStack(alignment: .leading, spacing: 12) {
                Text("Category")
                    .font(.headline)
                    .foregroundColor(AppTheme.Colors.textDark)
                
                Menu {
                    ForEach(0..<currentCategories.count, id: \.self) { index in
                        Button(action: { self.category = currentCategories[index] }) {
                            Text(currentCategories[index])
                                .font(.body)
                                .foregroundColor(AppTheme.Colors.textDark)
                        }
                    }
                } label: {
                    HStack {
                        Text(category)
                            .foregroundColor(AppTheme.Colors.textDark)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
            }
            
            // Description
            VStack(alignment: .leading, spacing: 12) {
                Text("Description (Optional)")
                    .font(.headline)
                    .foregroundColor(AppTheme.Colors.textDark)
                
                TextField("Add note", text: $note)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
            }
            
            Spacer()
            
            // Bottom Buttons
            HStack(spacing: 16) {
                Button(action: { dismiss() }) {
                    Text("Cancel")
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.Colors.textDark)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                        )
                }
                
                Button(action: {
                    // TODO: Save transaction
                    dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(AppTheme.Colors.primary)
                        )
                }
            }
        }
        .padding()
        .background(AppTheme.Colors.background)
    }
}

struct TransactionTypeButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.headline)
            .foregroundColor(isSelected ? .white : AppTheme.Colors.textDark)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? color : Color(.systemGray6))
            )
        }
    }
}

#Preview {
    NewTransactionView()
} 