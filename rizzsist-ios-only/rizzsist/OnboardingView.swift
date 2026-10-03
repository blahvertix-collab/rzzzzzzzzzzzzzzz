import SwiftUI

struct OnboardingView: View {
    var onDone: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Welcome to Rizzsist")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("To use the Rizzsist Keyboard:")
                    .font(.headline)
                
                Text("1. Open Settings > General > Keyboard > Add New Keyboard...")
                Text("2. Select 'RizzsistKeyboard' from Third-Party Keyboards")
                Text("3. Allow full access if prompted (for generating suggestions via your backend)")
                Text("4. Tap Done when you've added the keyboard")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Button("Done", action: onDone)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
