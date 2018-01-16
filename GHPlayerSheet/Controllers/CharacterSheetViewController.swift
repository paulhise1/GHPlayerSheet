import UIKit

class CharacterSheetViewController: UIViewController {

    var characterModel : CharacterModel?
    
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var perksLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameContainer: UIView!
    @IBOutlet weak var stateModifierContainerView: UIView!
    @IBOutlet weak var statModifierContainerLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let statModifierView = Bundle.main.loadNibNamed("StatModifierView", owner: self, options: nil)?.first as? StatModifierView {
            stateModifierContainerView.addSubview(statModifierView)
            statModifierView.frame = stateModifierContainerView.bounds
            statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
            
        }
//        className.text = characterModel?.characterClass.rawValue
//        characterName.text = characterModel?.name
//        level.text = String(describing: characterModel!.level)
    }
    
    //MARK: - Button handling
}
