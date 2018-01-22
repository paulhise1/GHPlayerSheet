import UIKit
import DynamicBlurView


class CharacterSheetViewController: UIViewController {
    
    //MARK: - Constants
    struct Constants {
        static let nameDefaultText = "Enter Name"
    }

    //MARK: - Class Properties
    let characterDatasource = CharactersDatasource()
    var currentCharacter : CharacterModel?
    var blurView: DynamicBlurView?
    
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var perksLabel: UILabel!
    @IBOutlet weak var stateModifierContainerView: UIView!
    var statModifierView: StatModifierView!
    @IBOutlet weak var statModifierContainerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var notesContainerView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCharacter = characterDatasource.getCharacter()
        
        setupStatModifierView()
        setupNotesView()
        setupDefaultNameLabelAppearance()
        
    }
    
    //MARK: - Helper Methods
    func setupDefaultNameLabelAppearance() {
        nameLabel.text = Constants.nameDefaultText
        nameLabel.textColor = .lightGray
    }
    
    func addBlurEffect(){
        // Would like to animate, animation was stuttered
        blurView = DynamicBlurView(frame: view.bounds)
        blurView?.isUserInteractionEnabled = true
        blurView?.blurRadius = 2
        view.addSubview(blurView!)
    }

    func removeBlurEffect(){
        blurView?.blurRadius = 0
        blurView?.removeFromSuperview()
    }
    
}


//MARK: - StatModifier View Methods
extension CharacterSheetViewController: StatModifierViewDelegate {
    
    func statModifierViewDidBeginModifying(sender: StatModifierView) {
        addBlurEffect()
        view.bringSubview(toFront: stateModifierContainerView)
    }
    
    func statModifierViewDidEndModifying(sender: StatModifierView) {
        removeBlurEffect()
    }
    
    func updateGold(amount: Int) {
        if let goldAmount = currentCharacter?.updateGold(amount: amount) {
            statModifierView.goldAmount = goldAmount
        }
    }
    
    func updateExperience(amount: Int) {
        if let experienceAmount = currentCharacter?.updateExperience(amount: amount) {
            statModifierView.experienceAmount = experienceAmount
        }
    }

}


//MARK: - Character Name TextField Methods
extension CharacterSheetViewController: UITextFieldDelegate {
    
    @IBAction func enterNameButtonTapped(_ sender: Any) {
        let textField = UITextField()
        createNameEditingTextField(textField: textField)
        addBlurEffect()
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
        removeBlurEffect()
    }
}


//MARK: - Setup Child Views
extension CharacterSheetViewController {
    
    func setupStatModifierView() {
        statModifierView = Bundle.main.loadNibNamed(String(describing: StatModifierView.self), owner: self, options: nil)?.first as? StatModifierView
        stateModifierContainerView.addSubview(statModifierView)
        statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
        statModifierView.frame = stateModifierContainerView.bounds
        statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        statModifierView.goldAmount = (currentCharacter?.gold)!
        statModifierView.experienceAmount = (currentCharacter?.experience)!
        statModifierView.delegate = self
    }
    
    func setupNotesView() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Notes View Controller") {
            addChildViewController(controller)
            controller.view.frame = notesContainerView.bounds
            controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            notesContainerView.addSubview(controller.view)
            controller.didMove(toParentViewController: self)
        }
    }
}



