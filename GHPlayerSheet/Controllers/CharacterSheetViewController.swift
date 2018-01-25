import UIKit
import DynamicBlurView


class CharacterSheetViewController: UIViewController {
    
    //MARK: - Constants
    struct Constants {
        static let nameDefaultText = "Enter Name"
        static let NotesViewControllerID =  "Notes View Controller"
    }

    //MARK: - Class Properties
    var characterManager: CharacterManager?
    var blurView: DynamicBlurView?
    var textField: UITextField?
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var statModifierView: StatModifierView?
    
    @IBOutlet weak var stateModifierContainerView: UIView!
    @IBOutlet weak var statModifierContainerLeadingConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var notesContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterManager = CharacterManager()
        setupStatModifierView()
        setupNotesView()
        setupDefaultNameLabelAppearance()
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
    
    func didUpdateGold(amount: Int) {
        if let statModifierView = statModifierView, let goldAmount = characterManager?.updateGold(amount: amount) {
            statModifierView.goldAmount = goldAmount
        }
    }
    
    func didUpdateExperience(amount: Int) {
        if let statModifierView = statModifierView, let experienceAmount = characterManager?.updateExperience(amount: amount) {
            statModifierView.experienceAmount = experienceAmount
        }
    }

}

//MARK: - Character Name Button and TextField Methods
extension CharacterSheetViewController: UITextFieldDelegate {
    
    func setupDefaultNameLabelAppearance() {
        if characterManager?.character?.name != "" {
            nameLabel.text = characterManager?.character?.name
            nameLabel.textColor = UIColor.flatMagenta()
        } else {
            nameLabel.text = Constants.nameDefaultText
            nameLabel.textColor = .lightGray
        }
    }
    
    @IBAction func enterNameButtonTapped(_ sender: Any) {
        addBlurEffect()
        createNameEditingTextField()
    }
    
    func createNameEditingTextField() {
        textField = UITextField()
        let width: CGFloat = 100.0
        let frame = CGRect(x: view.frame.size.width/2-width/2, y: 100, width: width, height: 40)
        if let textField = textField {
            textField.frame = frame
            textField.delegate = self
            textField.backgroundColor = UIColor(white: 1, alpha: 0.4)
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
            view.addSubview(textField)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nameLabel.text
        if nameLabel.text == Constants.nameDefaultText {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nameText = textField.text {
            characterManager?.setName(name: nameText)
        }
        nameLabel.text = characterManager?.character?.name
        nameLabel.textColor = UIColor.flatMagenta()
        if textField.text == "" {
            setupDefaultNameLabelAppearance()
        }
        textField.removeFromSuperview()
        removeBlurEffect()
        
        view.endEditing(true)
        return true
    }
    
}

extension CharacterSheetViewController {
    
    //MARK: - Helper Methods
    func addBlurEffect(){
        // Would like to animate, animation was stuttered
        blurView = DynamicBlurView(frame: view.bounds)
        blurView?.isUserInteractionEnabled = true
        blurView?.blurRadius = 2
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.dismissActiveView(sender:)))
        if let blurView = blurView {
            view.addSubview(blurView)
            blurView.addGestureRecognizer(gesture)
        }
        
        
    }
    
    @objc func dismissActiveView(sender : UITapGestureRecognizer) {
        if let textField = textField {
            textField.removeFromSuperview()
            removeBlurEffect()
        }
        if let statModifierView = statModifierView {
            statModifierView.dismissNumpad()
            removeBlurEffect()
        }
    }
    
    func removeBlurEffect(){
        blurView?.blurRadius = 0
        blurView?.removeFromSuperview()
    }
    
    //MARK: - Setup Child Views methods
    func setupStatModifierView() {
        statModifierView = Bundle.main.loadNibNamed(String(describing: StatModifierView.self), owner: self, options: nil)?.first as? StatModifierView
        if let statModifierView = statModifierView {
            stateModifierContainerView.addSubview(statModifierView)
            statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
            statModifierView.frame = stateModifierContainerView.bounds
            statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            if let gold = characterManager?.character?.gold { statModifierView.goldAmount = (gold) }
            if let experience = characterManager?.character?.experience { statModifierView.experienceAmount = (experience) }
            statModifierView.delegate = self
        }
    }
    
    func setupNotesView() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: Constants.NotesViewControllerID) {
            addChildViewController(controller)
            controller.view.frame = notesContainerView.bounds
            controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            notesContainerView.addSubview(controller.view)
            controller.didMove(toParentViewController: self)
        }
    }
}



