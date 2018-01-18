import UIKit

class NotesViewController: UIViewController {

    var notesArray: Array<String> = []
    var selectedNoteText: String?
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteDateTimeLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Stubbed
        notesArray = ["Do fun missions", "feed bagzabones", "sup", "kill all the monsters", "especially the easy ones", "assist party members", "Slayin & Playin", "Blipz & Chipz!"]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func addNotePressed(_ sender: Any) {
        
        //Stubbed
        notesArray.append("hello world!")
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DisplayNoteViewController
        destinationVC.noteText = selectedNoteText
    }


}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        //Stubbed
        cell.noteTitleLabel.text = notesArray[indexPath.row]
        cell.noteDateTimeLabel.text = "Wednesday"
        cell.noteBodyLabel.text = "This is a test Body for my notes."
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Stubbed
        selectedNoteText = notesArray[indexPath.row]
        
        performSegue(withIdentifier: "toNote", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }







}









