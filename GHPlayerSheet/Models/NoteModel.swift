import Foundation

struct NoteModel: Codable, ModelProtocol {
    
    var text: String
    let creationDate: Date // Identifier
    var date: Date
    
    init(text: String, creationDate: Date, currentDate: Date) {
        self.text = text
        self.creationDate = creationDate
        self.date = currentDate
    }

    func identifier() -> Date {
        return creationDate
    }
}
