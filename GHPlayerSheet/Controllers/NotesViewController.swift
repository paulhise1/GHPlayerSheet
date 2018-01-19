import UIKit

class NotesViewController: UIViewController {

    var notesArray: Array<String> = []
    var selectedNoteText: String?
    
    
    //Stubbed
    var stubbedNoteBody = "Chaos needs no allies, for it dwells like a poison in every one of us."
    //notesArray = ["Do fun missions", "feed bagzabones", "sup", "kill all the monsters", "especially the easy ones", "assist party members", "Slayin & Playin", "Blipz & Chipz!"]
    var note1 = NoteModel(noteTitle: "Do fun missions", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "Wednesday")
    var note2 = NoteModel(noteTitle: "feed bagzabones", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "Yesterday")
    var note3 = NoteModel(noteTitle: "sup", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "1/10/18")
    var note4 = NoteModel(noteTitle: "kill all the monsters", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "12.15.17")
    var note5 = NoteModel(noteTitle: "especially the easy ones", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "Monday")
    var note6 = NoteModel(noteTitle: "assist party members", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "2:39 PM")
    var note7 = NoteModel(noteTitle: "Slayin & Playin", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "Tuesday")
    var note8 = NoteModel(noteTitle: "Blipz & Chipz!", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "Tuesday")
    var note9 = NoteModel(noteTitle: "Do more fun missions", noteBody: "Chaos needs no allies, for it dwells like a poison in every one of us.", noteUpdated: "Now")
    var noteModelArray: Array<NoteModel>?
    

    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Stubbed
        noteModelArray = [note1, note2, note3, note4, note5, note6, note7, note8]
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func addNotePressed(_ sender: Any) {
        
        //Stubbed
        noteModelArray?.append(note9)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DisplayNoteViewController
        destinationVC.noteText = selectedNoteText
    }


}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteModelArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        //Stubbed
        cell.noteTitleLabel.text = noteModelArray![indexPath.row].noteTitle
        cell.noteDateTimeLabel.text = noteModelArray![indexPath.row].noteUpdated
        cell.noteBodyLabel.text = noteModelArray![indexPath.row].noteBody
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Stubbed
        selectedNoteText = noteModelArray![indexPath.row].noteTitle + "\n" + noteModelArray![indexPath.row].noteBody
        
        performSegue(withIdentifier: "toNote", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            noteModelArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }







}









