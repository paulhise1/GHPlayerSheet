import UIKit

protocol DisplayNoteViewControllerDelegate: class {
    func updateNotesList(noteText: String, noteCreatedDate: Date, index: Int)
    func createNewNote(noteText: String)
    func trashedNote(index: Int)
}

class DisplayNoteViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: DisplayNoteViewControllerDelegate?
    var noteText: String?
    var noteCreatedDate: Date?
    var noteIndex: Int?
    var newNote: Bool?
    var newBackButton: UIBarButtonItem?
    var navBarButtonTitle = "Notes"
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavBar()
        setTextView()
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if newNote! {
            if textView.text != "" {
                delegate?.createNewNote(noteText: textView.text)
            }
        } else {
            delegate?.updateNotesList(noteText: textView.text, noteCreatedDate: noteCreatedDate!, index: noteIndex!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func trashNoteButton(_ sender: Any) {
        if newNote! {
            navigationController?.popViewController(animated: true)
        } else {
            delegate?.trashedNote(index: noteIndex!)
            navigationController?.popViewController(animated: true)
        }
    }

    func setTextView(){
        textView.delegate = self
        if noteText == "" {
            newNote = true
        } else {
            textView.text = noteText
            navBarButtonTitle = "Notes"
            newNote = false
        }
    
    }
    
    func setupCustomNavBar() {
        self.navigationItem.hidesBackButton = true
        newBackButton = UIBarButtonItem(title: navBarButtonTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(DisplayNoteViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if newNote! {
            newBackButton?.title = "Add Note"
        } else {
            newBackButton?.title = "Update Note"
        }
    }
    
    
}



