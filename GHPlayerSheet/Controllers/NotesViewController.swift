import UIKit

class NotesViewController: UIViewController, DisplayNoteViewControllerDelegate {
    
    struct Constants {
        static let pathComponent = "notes.plist"
        static let noteCellID = "noteCell"
        static let segueToDisplayNoteID = "toUpdateNote"
    }
    
    let notesDatasource: ModelDatasource<NoteModel>
    var selectedNote: NoteModel?

    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        let url = URL.libraryFilePathWith(finalPathComponent: Constants.pathComponent)
        self.notesDatasource = ModelDatasource(with: url)
        
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func didUpdateNote(note: NoteModel) {
        if note.text == "" {
            notesDatasource.remove(model: note)
        } else {
            notesDatasource.update(model: note)
        }
        tableView.reloadData()
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        selectedNote = nil
        performSegue(withIdentifier: Constants.segueToDisplayNoteID, sender: self)
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
        if segue.identifier == Constants.segueToDisplayNoteID {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.noteCellID, for: indexPath) as! NoteTableViewCell
        
        let noteText = notesDatasource.modelAt(index: indexPath.row).text
        let dateString = Date.dateToStringFormater(date: notesDatasource.modelAt(index: indexPath.row).date)
        let noteTitle = noteTitleFrom(noteText: noteText)
        
        cell.noteTitleLabel.text = noteTitle
        cell.noteDateTimeLabel.text = dateString
        cell.noteBodyLabel.text = noteMessageFrom(noteText: noteText, noteTitle: noteTitle)
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedNote = notesDatasource.modelAt(index: indexPath.row)
        performSegue(withIdentifier: Constants.segueToDisplayNoteID, sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let noteModel = notesDatasource.modelAt(index: indexPath.row)
            notesDatasource.remove(model: noteModel)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

