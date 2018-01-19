import Foundation


class NotesDatasource {
    
    var notesList: Array<NoteModel>
    private let dataFilePath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent("Notes.plist")
    
    init() {
        notesList = [NoteModel]()
        loadNotesList()
    }
    
    func saveNotes() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.notesList)
            try data.write(to: self.dataFilePath!)
            print("Saved Notes.plist to user's Library")
            print("new plist has \(notesList.count) notes")
        } catch {
            print("Error encoding notesList to Notes.plist: \(error)")
        }
        
            }
    
    func loadNotesList() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                notesList = try decoder.decode([NoteModel].self, from: data)
            } catch {
                print("Error decoding notesList from Notes.plist: \(error)")
            }
        } else {
            notesList = Array<NoteModel>()
        }
    }
    
    
//    var note1 = NoteModel(noteTitle: "Do fun missions", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "Wednesday")
//    var note2 = NoteModel(noteTitle: "feed bagzabones", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "Yesterday")
//    var note3 = NoteModel(noteTitle: "sup", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "1/10/18")
//    var note4 = NoteModel(noteTitle: "kill all the monsters", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "12.15.17")
//    var note5 = NoteModel(noteTitle: "especially the easy ones", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "Monday")
//    var note6 = NoteModel(noteTitle: "assist party members", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "2:39 PM")
//    var note7 = NoteModel(noteTitle: "Slayin & Playin", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "Tuesday")
//    var note8 = NoteModel(noteTitle: "Blipz & Chipz!", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "Tuesday")
//    var note9 = NoteModel(noteTitle: "Do more fun missions", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdatedDate: "Now")
//
}


