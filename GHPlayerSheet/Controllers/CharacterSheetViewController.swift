import UIKit

class CharacterSheetViewController: UIViewController {

    var characterModel : CharacterModel?
    
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
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
        let width: CGFloat = 100.0
        let frame = CGRect(x: view.frame.size.width/2-width/2, y: 100, width: width, height: 40)
        textField.frame = frame
        textField.backgroundColor = UIColor(white: 1, alpha: 0.3)
        view.addSubview(textField)
        textField.returnKeyType = .done
        textField.becomeFirstResponder()
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
