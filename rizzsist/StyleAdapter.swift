import Foundation

struct RizzMode: Identifiable, Hashable {
    let id = UUID()
    let key: String
    let name: String
}

final class StyleAdapter {
    static let shared = StyleAdapter()
    private init() {}
    
    func analyzeStyle(from text: String) -> String {
        // TODO: Simple style analysis - can be enhanced
        return "natural casual"
    }
}
