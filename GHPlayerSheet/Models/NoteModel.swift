import Foundation

class NoteModel {
    
    var noteTitle: String
    var noteBody: String
    var noteUpdated: String
    
    init(noteTitle: String, noteBody: String, noteUpdated: String) {
        self.noteTitle = noteTitle
        self.noteBody = noteBody
        self.noteUpdated = noteUpdated
        
    }
    
    func convertDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        print(dateFormatter.string(from: date))
    }
    
    
    
}
