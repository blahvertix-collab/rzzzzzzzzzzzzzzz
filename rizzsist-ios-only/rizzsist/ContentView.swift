import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var result = ""
    @State private var selectedMode = "general"
    @State private var intensity = 3.0
    @State private var isLoading = false
    
    let modes = ["general", "smooth", "cute", "funny", "spicy"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Picker("Mode", selection: $selectedMode) {
                    ForEach(modes, id: \.self) { Text($0.capitalized) }
                }
                .pickerStyle(.segmented)
                
                VStack(alignment: .leading) {
                    Text("Intensity: \(Int(intensity))")
                    Slider(value: $intensity, in: 1...5, step: 1)
                }
                .padding(.horizontal)
                
                TextField("Chat context or situation", text: $input, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(4...8)
                
                Button(action: generate) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Generate Rizz")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading || input.isEmpty)
                
                ScrollView {
                    Text(result)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                Button("Import Chat (Manual)") {
                    // TODO: Present document picker for user-exported chats
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Rizzsist")
        }
    }
    
    func generate() {
        isLoading = true
        Task {
            do {
                let mode = AIMode(rawValue: selectedMode) ?? .general
                let res = try await AIService.shared.generateRizz(
                    context: input,
                    mode: mode,
                    intensity: Int(intensity),
                    styleHint: StyleAdapter.shared.analyzeStyle(from: input)
                )
                await MainActor.run {
                    result = res
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    result = "Error: \(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
    }
}
