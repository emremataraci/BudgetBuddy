import SwiftUI

struct GoalsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showAddGoalSheet = false
    
    // Sample goals data
    let goals = [
        GoalModel(
            title: "House Down Payment",
            targetAmount: 50000,
            currentAmount: 15000,
            deadline: Calendar.current.date(byAdding: .month, value: 12, to: Date())!,
            status: .onTrack
        ),
        GoalModel(
            title: "Emergency Fund",
            targetAmount: 10000,
            currentAmount: 8000,
            deadline: Calendar.current.date(byAdding: .month, value: 8, to: Date())!,
            status: .almostThere
        ),
        GoalModel(
            title: "New Car",
            targetAmount: 20000,
            currentAmount: 2000,
            deadline: Calendar.current.date(byAdding: .month, value: 3, to: Date())!,
            status: .behindSchedule
        )
    ]
    
    var totalSaved: Double {
        goals.reduce(0) { $0 + $1.currentAmount }
    }
    
    var targetTotal: Double {
        goals.reduce(0) { $0 + $1.targetAmount }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Goals Overview
                    VStack(spacing: 16) {
                        HStack {
                            Text("Goals Overview")
                                .font(.headline)
                            Spacer()
                            Text("\(goals.count) Active Goals")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        
                        HStack(spacing: 16) {
                            // Total Saved
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Total Saved")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("$\(Int(totalSaved))")
                                    .font(.title2)
                                    .foregroundColor(AppTheme.Colors.primary)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(AppTheme.Colors.primary.opacity(0.1))
                            .cornerRadius(12)
                            
                            // Target
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Target")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("$\(Int(targetTotal))")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    // Goals List
                    VStack(spacing: 16) {
                        ForEach(goals) { goal in
                            GoalCardView(goal: goal)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Financial Goals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddGoalSheet = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(AppTheme.Colors.primary)
                    }
                }
            }
            .sheet(isPresented: $showAddGoalSheet) {
                AddGoalSheet()
            }
        }
    }
}

struct GoalCardView: View {
    let goal: GoalModel
    
    var statusColor: Color {
        switch goal.status {
        case .onTrack:
            return .green
        case .almostThere:
            return .purple
        case .behindSchedule:
            return .orange
        }
    }
    
    var statusText: String {
        switch goal.status {
        case .onTrack:
            return "On track"
        case .almostThere:
            return "Almost there!"
        case .behindSchedule:
            return "Behind schedule"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.title)
                        .font(.headline)
                    Text("Target: \(goal.deadline.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
            
            Text("$\(Int(goal.currentAmount)) of $\(Int(goal.targetAmount))")
                .font(.subheadline)
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 8)
                        .opacity(0.1)
                        .foregroundColor(statusColor)
                    
                    Rectangle()
                        .frame(width: geometry.size.width * goal.progress, height: 8)
                        .foregroundColor(statusColor)
                }
                .cornerRadius(4)
            }
            .frame(height: 8)
            
            HStack {
                Image(systemName: goal.status == .onTrack ? "checkmark.circle.fill" : 
                                goal.status == .almostThere ? "flag.fill" : "exclamationmark.triangle.fill")
                    .foregroundColor(statusColor)
                Text(statusText)
                    .font(.caption)
                    .foregroundColor(statusColor)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct AddGoalSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var goalName: String = ""
    @State private var goalType: String = "Savings"
    @State private var targetAmount: Double = 0.0
    @State private var deadline: Date = Date()
    @State private var description: String = ""
    @State private var showDatePicker = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Add New Goal")
                    .font(.headline)
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Goal Name*")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField("Enter goal name", text: $goalName)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Goal Type*")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Menu {
                        Button("Savings") { goalType = "Savings" }
                        Button("Investment") { goalType = "Investment" }
                        Button("Debt") { goalType = "Debt" }
                    } label: {
                        HStack {
                            Text(goalType)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Target Amount*")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    HStack {
                        Text("$")
                            .foregroundColor(.gray)
                        TextField("0.00", value: $targetAmount, format: .number)
                            .keyboardType(.decimalPad)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Deadline*")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Button(action: {
                        showDatePicker = true
                    }) {
                        HStack {
                            Text(dateFormatter.string(from: deadline))
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    }
                }
                .sheet(isPresented: $showDatePicker) {
                    NavigationView {
                        DatePicker("", selection: $deadline, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .onChange(of: deadline) { _ in
                                showDatePicker = false
                            }
                            .navigationTitle("Select Deadline")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Done") {
                                        showDatePicker = false
                                    }
                                }
                            }
                    }
                    .presentationDetents([.medium])
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField("Add any additional notes...", text: $description)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                }
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                Button(action: {
                    // TODO: Save goal logic
                    dismiss()
                }) {
                    Text("Save Goal")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Button(action: { dismiss() }) {
                    Text("Cancel")
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    GoalsView()
        .environmentObject(AppState())
} 