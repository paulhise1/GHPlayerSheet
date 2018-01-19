import UIKit

protocol DisplayNoteViewControllerDelegate: class {
    func updateNotesList(noteText: String, noteCreatedDate: Date, index: Int)
    func createNewNote(noteText: String)
}

class DisplayNoteViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: DisplayNoteViewControllerDelegate?
    var noteText: String?
    var noteCreatedDate: Date?
    var noteIndex: Int?
    var newNote: Bool?
    var navBarButtonLabel = "Add Note"
    
    
    @IBOutlet weak var textField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavBar()
        if noteText == "" {
            newNote = true
        } else {
            textField.text = noteText
            navBarButtonLabel = "Notes"
            newNote = false
        }
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if newNote! {
            if textField.text != "" {
                delegate?.createNewNote(noteText: textField.text)
            }
        } else {
            delegate?.updateNotesList(noteText: textField.text, noteCreatedDate: noteCreatedDate!, index: noteIndex!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setupCustomNavBar() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: navBarButtonLabel, style: UIBarButtonItemStyle.plain, target: self, action: #selector(DisplayNoteViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navBarButtonLabel = "Update Note"
    }
    
    
}



