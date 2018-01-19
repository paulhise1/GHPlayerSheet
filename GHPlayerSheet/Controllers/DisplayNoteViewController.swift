import UIKit



protocol DisplayNoteViewControllerDelegate {
    func updateNoteList(noteTitle: String, noteBody: String)
}




class DisplayNoteViewController: UIViewController {
    
    var noteText: String?
    
    @IBOutlet weak var noteTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    
    

    
    
}



