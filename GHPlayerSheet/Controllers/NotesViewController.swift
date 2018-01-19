import UIKit

class NotesViewController: UIViewController, DisplayNoteViewControllerDelegate {
   
    var notesDatasource = NotesDatasource()
    var selectedNoteText: String?
    var selectedNoteDate: Date?
    var selectedNoteIndex: Int?

    
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    
    func updateNotesList(noteText: String, noteCreatedDate: Date, index: Int) {
        let date = Date()
        let createdDate = noteCreatedDate
        var note = NoteModel(noteText: noteText, creationDate: createdDate, updatedDate: date)
        notesDatasource.notesList[index] = note
        notesDatasource.saveNote()
        tableView.reloadData()
    }
    
    func createNewNote(noteText: String) {
        let date = Date()
        var note = NoteModel(noteText: noteText, creationDate: date, updatedDate: date)
        notesDatasource.notesList.append(note)
        notesDatasource.saveNote()
        tableView.reloadData()
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        performSegue(withIdentifier: "toNewNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DisplayNoteViewController
        if segue.identifier == "toUpdateNote" {
            destinationVC.noteText = selectedNoteText
            destinationVC.noteCreatedDate = selectedNoteDate
            destinationVC.noteIndex = selectedNoteIndex
        } else {
            destinationVC.noteText = ""
        }
        destinationVC.delegate = self
    }


}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesDatasource.notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        let noteText = notesDatasource.notesList[indexPath.row].noteText
        let createdOnDateAsString = dateToStringFormater(date: notesDatasource.notesList[indexPath.row].creationDate)
        let updatedOnDateAsString = dateToStringFormater(date: notesDatasource.notesList[indexPath.row].updatedDate)
        
        cell.noteTitleLabel.text = createNoteTitle(noteText: noteText)
        cell.noteDateTimeLabel.text = createdOnDateAsString
        cell.noteBodyLabel.text = noteText
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedNoteText = notesDatasource.notesList[indexPath.row].noteText
        selectedNoteDate = notesDatasource.notesList[indexPath.row].creationDate
        selectedNoteIndex = indexPath.row
        performSegue(withIdentifier: "toUpdateNote", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            notesDatasource.notesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func dateToStringFormater(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/DD"
        let dateAsString = formatter.string(from: Date())
        return dateAsString
    }
    
    func createNoteTitle(noteText: String) -> String {
        if noteText.count > 20 {
            let index = noteText.index(noteText.startIndex, offsetBy: 20)
            
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
        } else {
            return noteText
        }
    }



}
