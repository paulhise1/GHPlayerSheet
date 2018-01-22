import UIKit

class NotesViewController: UIViewController, DisplayNoteViewControllerDelegate {
    
    let notesDatasource = NotesDatasource()
    var selectedNote: NoteModel?

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func didUpdateNote(note: NoteModel) {
        if note.text == "" {
            notesDatasource.removeNote(note: note)
        } else {
            notesDatasource.updateNote(updatedNote: note)
        }
        tableView.reloadData()
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        selectedNote = nil
        performSegue(withIdentifier: "toUpdateNote", sender: self)
    }
    
    func dateToStringFormater(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/DD"
        let dateAsString = formatter.string(from: Date())
        return dateAsString
    }
    
    func dateDisplayer(){
        // want this to be like in notes app where it will say today, yesterday, weekday if in this last week, and otherwise show the date.
    }
    
    
    func noteTitleFrom(noteText: String?) -> String {
        let noteText = noteText ?? ""
        
        guard noteText.count > 24 else {
            return noteText
        }
        
        let index = noteText.index(noteText.startIndex, offsetBy: 24)
        
        let subString = noteText.prefix(upTo: index)
        let newString = String(subString)
        if let theIndex = newString.index(of: "\n") {
            let subString = noteText.prefix(upTo: theIndex)
            let titleString = String(subString)
            return titleString
        } else {
            let titleString = String(subString)
            return titleString
        }
    }
    // want to do a filter that pulls out all of the \n characters for the message label
    func noteMessageFrom(noteText: String, noteTitle: String) -> String {
        let titleLength = noteTitle.count
        var noteMessage = String(describing: noteText.dropFirst(titleLength))
        while noteMessage.first == "\n" {
            noteMessage = String(describing: noteMessage.dropFirst())
        }
        return noteMessage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateNote" {
            let destinationVC = segue.destination as! DisplayNoteViewController
            destinationVC.note = selectedNote
            destinationVC.delegate = self
        }
    }

}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesDatasource.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        let noteText = notesDatasource.noteAt(index: indexPath.row).text
        
        let date = dateToStringFormater(date: notesDatasource.noteAt(index: indexPath.row).date)
        let noteTitle = noteTitleFrom(noteText: noteText)
        
        cell.noteTitleLabel.text = noteTitle
        cell.noteDateTimeLabel.text = date
        cell.noteBodyLabel.text = noteMessageFrom(noteText: noteText, noteTitle: noteTitle)
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedNote = notesDatasource.noteAt(index: indexPath.row)
        performSegue(withIdentifier: "toUpdateNote", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let note = notesDatasource.noteAt(index: indexPath.row)
            notesDatasource.removeNote(note: note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
}

//MARK: - extension on String to help with manipulating substrings
extension String {
    func index(at offset: Int, from start: Index? = nil) -> Index? {
        return index(start ?? startIndex, offsetBy: offset, limitedBy: endIndex)
    }
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
    subscript(_ range: CountableRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: CountableClosedRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: PartialRangeUpTo<Int>) -> Substring {
        return prefix(range.upperBound)
    }
    subscript(_ range: PartialRangeThrough<Int>) -> Substring {
        return prefix(range.upperBound+1)
    }
    subscript(_ range: PartialRangeFrom<Int>) -> Substring {
        return suffix(max(0,count-range.lowerBound))
    }
}

extension Substring {
    var string: String { return String(self) }
}

//let test = "Hello USA 🇺🇸!!! Hello Brazil 🇧🇷!!!"
//test.character(at: 10)   // "🇺🇸"
//test.character(at: 11)   // "!"
//test[10...]   // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
//test[10..<12]   // "🇺🇸!"
//test[10...12]   // "🇺🇸!!"
//test[...10]   // "Hello USA 🇺🇸"
//test[..<10]   // "Hello USA "
//test.first   // "H"
//test.last    // "!"
//
//// Note that they all return a Substring of the original String.
//// To create a new String you need to add .string as follow
//test[10...].string  // "🇺🇸!!! Hello Brazil 🇧🇷!!!"

