import UIKit
import DynamicBlurView


class CharacterSheetViewController: UIViewController {
    
    //MARK: - Constants
    struct Constants {
        static let nameDefaultText = "Enter Name"
        static let toNotesSegueID =  "Notes View Controller"
    }

    //MARK: - Class Properties
    var character: CharacterModel?
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
        
        //stubbed
        character = CharacterModel(characterClass: .mindthief, gold: 30, experience: 45)
        
        setupStatModifierView()
        setupNotesView()
        setupDefaultNameLabelAppearance()
    }
    
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
        if let statModifierView = statModifierView, let goldAmount = character?.updateGold(amount: amount) {
            statModifierView.goldAmount = goldAmount
        }
    }
    
    func updateExperience(amount: Int) {
        if let statModifierView = statModifierView, let experienceAmount = character?.updateExperience(amount: amount) {
            statModifierView.experienceAmount = experienceAmount
        }
    }

}

//MARK: - Character Name Button and TextField Methods
extension CharacterSheetViewController: UITextFieldDelegate {
    
    func setupDefaultNameLabelAppearance() {
        if character?.name != "" {
            nameLabel.text = character?.name
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
        nameLabel.text = textField.text
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

//MARK: - Setup Child Views
extension CharacterSheetViewController {
    
    func setupStatModifierView() {
        statModifierView = Bundle.main.loadNibNamed(String(describing: StatModifierView.self), owner: self, options: nil)?.first as? StatModifierView
        if let statModifierView = statModifierView {
            stateModifierContainerView.addSubview(statModifierView)
            statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
            statModifierView.frame = stateModifierContainerView.bounds
            statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            if let gold = character?.gold { statModifierView.goldAmount = (gold) }
            if let experience = character?.experience { statModifierView.experienceAmount = (experience) }
            statModifierView.delegate = self
        }
    }
    
    func setupNotesView() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: Constants.toNotesSegueID) {
            addChildViewController(controller)
            controller.view.frame = notesContainerView.bounds
            controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            notesContainerView.addSubview(controller.view)
            controller.didMove(toParentViewController: self)
        }
    }
}



