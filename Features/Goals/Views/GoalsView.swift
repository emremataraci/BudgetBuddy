import SwiftUI

struct GoalsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showAddGoalSheet = false
    @State private var selectedDate = Calendar.current.date(byAdding: .month, value: 2, to: Date())!
    
    // Dummy goal data
    let goal = GoalModel(
        title: "New iPhone",
        targetAmount: 1299,
        currentAmount: 850,
        deadline: Calendar.current.date(byAdding: .month, value: 2, to: Date())!,
        category: "Electronics"
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Main Goal Card
                    VStack(spacing: 20) {
                        // Goal Icon and Title
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(AppTheme.Colors.primary.opacity(0.1))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "iphone")
                                    .font(.system(size: 36))
                                    .foregroundColor(AppTheme.Colors.primary)
                            }
                            
                            Text(goal.title)
                                .font(AppTheme.Typography.title2)
                                .foregroundColor(AppTheme.Colors.textDark)
                        }
                        .padding(.top)
                        
                        // Progress Circle
                        ZStack {
                            Circle()
                                .stroke(AppTheme.Colors.primary.opacity(0.1), lineWidth: 20)
                            
                            Circle()
                                .trim(from: 0, to: goal.progress)
                                .stroke(AppTheme.Colors.secondary, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                            
                            VStack(spacing: 8) {
                                Text("\(Int(goal.progress * 100))%")
                                    .font(.system(size: 44, weight: .bold))
                                    .foregroundColor(AppTheme.Colors.secondary)
                                
                                Text("Complete")
                                    .font(AppTheme.Typography.body)
                                    .foregroundColor(AppTheme.Colors.textSecondary)
                            }
                        }
                        .frame(width: 200, height: 200)
                        .padding(.vertical)
                        
                        // Amount Details
                        VStack(spacing: 16) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Current")
                                        .font(AppTheme.Typography.caption)
                                        .foregroundColor(AppTheme.Colors.textSecondary)
                                    Text("$\(Int(goal.currentAmount))")
                                        .font(AppTheme.Typography.title3)
                                        .foregroundColor(AppTheme.Colors.textDark)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("Target")
                                        .font(AppTheme.Typography.caption)
                                        .foregroundColor(AppTheme.Colors.textSecondary)
                                    Text("$\(Int(goal.targetAmount))")
                                        .font(AppTheme.Typography.title3)
                                        .foregroundColor(AppTheme.Colors.textDark)
                                }
                            }
                            
                            // Remaining Amount
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Remaining")
                                    .font(AppTheme.Typography.caption)
                                    .foregroundColor(AppTheme.Colors.textSecondary)
                                
                                Text("$\(Int(goal.targetAmount - goal.currentAmount))")
                                    .font(AppTheme.Typography.title3)
                                    .foregroundColor(AppTheme.Colors.accent)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(AppTheme.Colors.background)
                        .cornerRadius(Constants.Layout.cornerRadius)
                        .shadow(radius: 2)
                        
                        // Target Date
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Target Date")
                                .font(AppTheme.Typography.caption)
                                .foregroundColor(AppTheme.Colors.textSecondary)
                            
                            DatePicker(
                                "Select Date",
                                selection: $selectedDate,
                                in: Date()...,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .tint(AppTheme.Colors.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(AppTheme.Colors.background)
                        .cornerRadius(Constants.Layout.cornerRadius)
                        .shadow(radius: 2)
                    }
                    .padding()
                    .background(AppTheme.Colors.background)
                    .cornerRadius(Constants.Layout.cornerRadius)
                    .shadow(radius: 4)
                    
                    // Add Money Button
                    Button(action: {
                        // TODO: Implement add money action
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Money")
                        }
                        .font(AppTheme.Typography.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.Colors.secondary)
                        .cornerRadius(Constants.Layout.cornerRadius)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("My Goal")
            .foregroundColor(AppTheme.Colors.textDark)
            .background(AppTheme.Colors.groupedBackground)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddGoalSheet = true
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(AppTheme.Colors.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    GoalsView()
        .environmentObject(AppState())
} 