import Foundation

struct NoteModel: Codable {
    
    var text: String
    let creationDate: Date // Identifier
    var date: Date
    
    init(text: String, creationDate: Date, currentDate: Date) {
        self.text = text
        self.creationDate = creationDate
        self.date = currentDate
    }

}
