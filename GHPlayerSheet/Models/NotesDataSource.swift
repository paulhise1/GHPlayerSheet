import Foundation

class NotesDatasource {
    
    private var notesList: [NoteModel]
    
    init() {
        notesList = NotesDatasource.loadNotesList()
        print(URL.notesDataFilePath())
    }
    
    func removeNote(note: NoteModel) {
        notesList = notesList.filter() {
            return $0.creationDate != note.creationDate
        }
        saveNotes()
    }
    
    func updateNote(updatedNote: NoteModel) {
        removeNote(note: updatedNote)
        notesList.insert(updatedNote, at: 0)
        saveNotes()
    }
    
    func noteAt(index: Int) -> NoteModel {
        return notesList[index]
    }
    
    func count() -> Int {
        return notesList.count
    }
    
    private func saveNotes() {
        guard let url = URL.notesDataFilePath() else {
            return
        }
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(notesList)
            try data.write(to: url)
        } catch {
            print("Error encoding notesList to notes.plist: \(error)")
        }
    }
    
    private static func loadNotesList() -> [NoteModel] {
        guard let url = URL.notesDataFilePath(), let data = try? Data(contentsOf: url) else {
            return [NoteModel]()
        }

        do {
            return try PropertyListDecoder().decode([NoteModel].self, from: data)
        } catch {
            return [NoteModel]()
        }
    }
    
}

extension URL {
    static func notesDataFilePath() -> URL? {
        return (FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent("notes.plist"))
    }
}


