import UIKit

class CharacterSheetViewController: UIViewController, UITextFieldDelegate, StatModifierViewDelegate {
    
    //MARK: - Constants
    struct Constants {
        static let nameDefaultText = "Enter Name"
    }

    //MARK: - Class Properties
    var character : CharacterModel?
    var blurEffectView = UIVisualEffectView()
    
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enteringNameProtectorView: UIView!
    @IBOutlet weak var perksLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var stateModifierContainerView: UIView!
    @IBOutlet weak var statModifierContainerLeadingConstraint: NSLayoutConstraint!
    
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: - Create Character for testing
        character = CharacterModel.init(characterClass: .brute, name: "fred", level: 3)
        character?.gold = 15
        character?.experience = 124
        
        
        setupStatModifierView()
        setupDefaultNameLabelAppearance()
        
    }
    
    
    //MARK: - Character Name Creation and Display
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
        if nameLabel.text == Constants.nameDefaultText {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameLabel.text = textField.text
        nameLabel.textColor = .blue
        if textField.text == "" {
            setupDefaultNameLabelAppearance()
        }
        textField.removeFromSuperview()
        view.sendSubview(toBack: enteringNameProtectorView)
        
    }
    
    
    //MARK: - statModifierView Delegate Methods
    func statModifierViewDidBeginModifying(sender: StatModifierView) {
        addBlurEffect()
        view.bringSubview(toFront: stateModifierContainerView)
    }
    
    func statModifierViewDidEndModifying(sender: StatModifierView) {
        removeBlurEffect()
    }
    
    func updateGold(updateGoldAmount: Int) {
        character?.gold = updateGoldAmount
    }
    
    func updateExperience(updateExperienceAmount: Int) {
        character?.experience = updateExperienceAmount
    }
    
    
    //MARK: - Setup Child Views
    func setupStatModifierView() {
        if let statModifierView = Bundle.main.loadNibNamed(String(describing: StatModifierView.self), owner: self, options: nil)?.first as? StatModifierView {
            stateModifierContainerView.addSubview(statModifierView)
            statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
            statModifierView.frame = stateModifierContainerView.bounds
            statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            statModifierView.goldAmount = (character?.gold)!
            statModifierView.experienceAmount = (character?.experience)!
            statModifierView.goldButton.setTitle(String(statModifierView.goldAmount), for: .normal)
            statModifierView.experienceButton.setTitle(String(statModifierView.experienceAmount), for: .normal)
            statModifierView.delegate = self
        }
    }
    
    
    //MARK: - Helper Methods
    func setupDefaultNameLabelAppearance() {
        nameLabel.text = Constants.nameDefaultText
        nameLabel.textColor = .lightGray
    }
    
    func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }

    func removeBlurEffect(){
        blurEffectView.removeFromSuperview()
    }
    
    
    
    
    
    
    
    
}






