import Foundation

struct ChatMessage: Codable {
    let role: String
    let content: String
}

struct AIRequest: Codable {
    let model: String
    let messages: [ChatMessage]
    let temperature: Double
    let max_tokens: Int?
}

struct AIResponse: Codable {
    struct Choice: Codable {
        let message: ChatMessage
    }
    let choices: [Choice]
}

enum AIMode: String, CaseIterable {
    case general, smooth, cute, funny, spicy
}

final class AIService {
    static let shared = AIService()
    private init() {}
    
    private let backendURL = URL(string: "https://YOUR_BACKEND.example.com/api/rizz")!
    
    func generateRizz(context: String, mode: AIMode, intensity: Int, styleHint: String? = nil) async throws -> String {
        let systemPrompt = "You are Rizzsist. Respectful, natural, context-aware suggestions. Mode: \(mode.rawValue), intensity: \(intensity)."
        let userPrompt = "Context:\n\(context)\n\nStyle hint: \(styleHint ?? "natural")\n\nReturn concise usable suggestion."
        
        let request = AIRequest(
            model: "gpt-4o-mini",
            messages: [
                ChatMessage(role: "system", content: systemPrompt),
                ChatMessage(role: "user", content: userPrompt)
            ],
            temperature: 0.8,
            max_tokens: 200
        )
        
        var urlRequest = URLRequest(url: backendURL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let response = try JSONDecoder().decode(AIResponse.self, from: data)
        return response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Try again."
    }
}
