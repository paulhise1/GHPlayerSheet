import UIKit
import DynamicBlurView


class CharacterSheetViewController: UIViewController, UITextFieldDelegate, StatModifierViewDelegate {
    
    //MARK: - Constants
    struct Constants {
        static let nameDefaultText = "Enter Name"
    }

    //MARK: - Class Properties
    var characterModel : CharacterModel?
    var blurView: DynamicBlurView?
    
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var perksLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var stateModifierContainerView: UIView!
    var statModifierView: StatModifierView!
    @IBOutlet weak var statModifierContainerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var notesContainerView: UIView!
    
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: - Stubbed Character for testing
        characterModel = CharacterModel(characterClass: .brute, name: "fred", level: 3)
        characterModel?.gold = 15
        characterModel?.experience = 124
        
        
        setupStatModifierView()
        setupNotesView()
        setupDefaultNameLabelAppearance()
        
    }
    
    
    //MARK: - Character Name Creation and Display
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
    
    
    //MARK: - statModifierView Delegate Methods
    func statModifierViewDidBeginModifying(sender: StatModifierView) {
        
        addBlurEffect()
        view.bringSubview(toFront: stateModifierContainerView)
    }
    
    func statModifierViewDidEndModifying(sender: StatModifierView) {
        removeBlurEffect()
    }
    
    func updateGold(amount: Int) {
        if let goldAmount = characterModel?.updateGold(amount: amount) {
            statModifierView.goldAmount = goldAmount
        }
    }
    
    func updateExperience(amount: Int) {
        if let experienceAmount = characterModel?.updateExperience(amount: amount) {
            statModifierView.experienceAmount = experienceAmount
        }
    }
    
    
    //MARK: - Setup Child Views
    func setupStatModifierView() {
        statModifierView = Bundle.main.loadNibNamed(String(describing: StatModifierView.self), owner: self, options: nil)?.first as? StatModifierView
        stateModifierContainerView.addSubview(statModifierView)
        statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
        statModifierView.frame = stateModifierContainerView.bounds
        statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        statModifierView.goldAmount = (characterModel?.gold)!
        statModifierView.experienceAmount = (characterModel?.experience)!
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
    
    //MARK: - Helper Methods
    func setupDefaultNameLabelAppearance() {
        nameLabel.text = Constants.nameDefaultText
        nameLabel.textColor = .lightGray
    }
    
    func addBlurEffect(){
        //FIXME: - Would like to animate, animation was stuttered
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






