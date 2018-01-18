import UIKit

class DisplayNoteViewController: UIViewController {
    
    var noteText: String?
    
    @IBOutlet weak var noteTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextField.text = noteText
       
    }

    
    

    
    
}



