import UIKit

class CharacterSheetViewController: UIViewController, UITextFieldDelegate {

    var characterModel : CharacterModel?
    
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enteringNameProtectorView: UIView!
    @IBOutlet weak var perksLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var stateModifierContainerView: UIView!
    @IBOutlet weak var statModifierContainerLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStatModifierView()
    }
    
    
    @IBAction func enterNameButtonTapped(_ sender: Any) {
        let textField = UITextField()
        createNameEditingTextField(textField: textField)
        view.bringSubview(toFront: enteringNameProtectorView)
        view.addSubview(textField)
        
    }
    
    func createNameEditingTextField(textField: UITextField) {
        let width: CGFloat = 100.0
        let frame = CGRect(x: view.frame.size.width/2-width/2, y: 100, width: width, height: 40)
        textField.frame = frame
        textField.delegate = self
        textField.backgroundColor = UIColor(white: 1, alpha: 0.4)
        textField.returnKeyType = .done
        textField.becomeFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nameLabel.text
        if nameLabel.text == "Enter name" {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        }
    }
    
    // Function called when done button is hit on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameLabel.text = textField.text
        nameLabel.textColor = .blue
        textField.resignFirstResponder()
        textField.removeFromSuperview()
        view.sendSubview(toBack: enteringNameProtectorView)
        return true
    }
    
    
    func setupStatModifierView() {
        if let statModifierView = Bundle.main.loadNibNamed("StatModifierView", owner: self, options: nil)?.first as? StatModifierView {
            stateModifierContainerView.addSubview(statModifierView)
            statModifierView.frame = stateModifierContainerView.bounds
            statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
        }
    }
    
    
    
}
