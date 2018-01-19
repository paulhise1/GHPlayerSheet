import Foundation

struct NoteModel: Codable {
    
    var noteText: String
    let creationDate: Date
    var updatedDate: Date
    
    init(noteText: String, creationDate: Date, updatedDate: Date) {
        self.noteText = noteText
        self.creationDate = creationDate
        self.updatedDate = updatedDate
    }

}
