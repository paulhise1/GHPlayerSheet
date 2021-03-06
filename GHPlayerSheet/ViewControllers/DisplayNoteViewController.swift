import UIKit

protocol DisplayNoteViewControllerDelegate: class {
    func didUpdateNote(note: Note)
}

class DisplayNoteViewController: UIViewController, UITextViewDelegate {
    
    var note: Note?
    
    weak var delegate: DisplayNoteViewControllerDelegate?
    var newBackButton: UIBarButtonItem?

    var navBarButtonTitle = "<"
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavBar()
        setTextView()
    }
    
    @objc func back(sender: UIBarButtonItem) {
        let creationDate = note?.creationDate ?? Date()
        let updatedNote = Note(text: textView.text, creationDate: creationDate, currentDate: Date())
        delegate?.didUpdateNote(note: updatedNote)
        navigationController?.popViewController(animated: true)
    }
    
    func setTextView(){
        textView.delegate = self
        textView.text = note?.text
    }
    
    func setupCustomNavBar() {
        self.navigationItem.hidesBackButton = true
        newBackButton = UIBarButtonItem(title: navBarButtonTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(DisplayNoteViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
}
