import Foundation
import UIKit

struct ChatImportResult {
    let source: String
    let context: String
}

protocol ChatImporter {
    func canImport() -> Bool
    func importChat(for recipient: String?) async throws -> ChatImportResult
}

/// Platform-aware importer. Note: iOS restricts direct access to other apps' data.
/// Prefer document picker (user-exported files) or share extensions.
final class ChatImportService {
    static let shared = ChatImportService()
    private init() {}
    
    func importFromUserSelection() async throws -> ChatImportResult {
        // In production: present UIDocumentPickerViewController or ShareSheet
        // User must explicitly provide exported chat file/text
        throw NSError(domain: "ChatImport", code: 1, userInfo: [NSLocalizedDescriptionKey: "Implement UI to let user select exported chat"])
    }
}
