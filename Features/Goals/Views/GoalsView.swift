import SwiftUI

struct GoalsView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<3) { index in
                        GoalCardView(
                            title: ["New Car", "Vacation", "Emergency Fund"][index],
                            current: [60000, 3000, 8000][index],
                            target: [100000, 5000, 10000][index]
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Goals")
        }
    }
}

struct GoalCardView: View {
    let title: String
    let current: Double
    let target: Double
    
    var progress: Double {
        current / target
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            ProgressView(value: progress)
                .tint(.blue)
            
            HStack {
                Text("$\(Int(current)) / $\(Int(target))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    GoalsView()
        .environmentObject(AppState())
} 