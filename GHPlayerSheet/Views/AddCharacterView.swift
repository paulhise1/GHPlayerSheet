import UIKit

protocol AddCharacterViewDelegate: class {
    func didCancelCharacterCreation()
    func didCreateCharacter(name: String, experience: Int)
}

class AddCharacterView: UIView {

    struct Constant {
        static let experienceLabel1 = "Enter Your"
        static let experienceLabel2 = "Experience"
        static let characterLabel1 = "Name Your"
        static let characterLabel2 = "Character"
        static let acceptButtonCreateTitle = "Create!"
    }
    
    weak var delegate: AddCharacterViewDelegate?
    
    @IBOutlet weak var characterCreationLabel1: UILabel!
    @IBOutlet weak var characterCreationLabel2: UILabel!
    @IBOutlet weak var classSymbolImageView: UIImageView!
    
    @IBOutlet weak var classSymbolLargeImageView: UIImageView!
    
    @IBOutlet weak var numPadContainerView: UIView!
    @IBOutlet weak var acceptButton: UIButton! {
        didSet {
            acceptButton.layer.cornerRadius = 6
            acceptButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    private var numPadView: NumPadView?
    private var experience: String?
    private var name: String?
    private var characterClass: CharacterClass.charClass?
    
    
    func configure(charClass: CharacterClass.charClass) {
        characterClass = charClass
        classSymbolImageView.image = UIImage(named: CharacterClass.characterSymbolForClass(charClass: charClass))
        nameTextField.isHidden = true
        characterInfoLabel.isHidden = true
        acceptButton.isEnabled = false
        levelLabel.isHidden = true
        characterCreationLabel1.text = Constant.experienceLabel1
        characterCreationLabel2.text = Constant.experienceLabel2
        setupNumPadView()
        nameTextField.delegate = self
    }

 
    @IBAction func acceptButtonTapped(_ sender: Any) {
        if characterCreationLabel2.text == Constant.experienceLabel2 {
            acceptEnteredExperience()
        } else if characterCreationLabel2.text == Constant.characterLabel2 {
            acceptEnteredName()
        } else if acceptButton.title(for: .normal)! == Constant.acceptButtonCreateTitle {
            guard let name = name, let xp = experience, let intXp = Int(xp) else { return }
            delegate?.didCreateCharacter(name: name, experience: intXp)
        }
    }
    
    private func acceptEnteredExperience() {
        if let numPadView = numPadView {
            acceptButton.isEnabled = false
            experience = numPadView.amountLabel.text
            numPadContainerView.isHidden = true
            nameTextField.isHidden = false
            nameTextField.keyboardType = .alphabet
            nameTextField.returnKeyType = .done
            nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            characterCreationLabel1.text = Constant.characterLabel1
            characterCreationLabel2.text = Constant.characterLabel2
            guard let xp = self.experience, let intXp = Int(xp) else { return }
            levelLabel.isHidden = false
            levelLabel.text = "Level \(Character.levelForExperience(experience: intXp))"
        }
    }
    
    private func acceptEnteredName() {
        nameTextField.resignFirstResponder()
        characterCreationLabel1.isHidden = true
        characterCreationLabel2.text = ""
        characterCreationLabel2.isHidden = true
        name = nameTextField.text
        levelLabel.isHidden = true
        nameTextField.isHidden = true
        classSymbolImageView.isHidden = true
        guard let name = name, let xp = self.experience, let intXp = Int(xp), let charClass = characterClass else { return }
        classSymbolLargeImageView.image = UIImage(named: CharacterClass.characterSymbolForClass(charClass: charClass))
        characterInfoLabel.text = "\(name), A level \(Character.levelForExperience(experience: intXp)) \(charClass.rawValue)"
        characterInfoLabel.isHidden = false
        acceptButton.setTitle(Constant.acceptButtonCreateTitle, for: .normal)
    }

    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.didCancelCharacterCreation()
    }
    
}

extension AddCharacterView: NumPadViewDelegate, UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        name = nameTextField.text
        if name == "" {
            acceptButton.isEnabled = false
        } else {
            acceptButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if acceptButton.isEnabled {
            acceptEnteredName()
        }
        return true
    }
    
    func setupNumPadView () {
        numPadView = Bundle.main.loadNibNamed(String(describing: NumPadView.self), owner: self, options: nil)?.first as? NumPadView
        if let numPadView = numPadView {
            numPadContainerView.addSubview(numPadView)
            numPadView.frame = numPadContainerView.bounds
            numPadView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            numPadView.delegate = self
            numPadView.maxNumber = 500
            numPadView.digitsAllowed = 3
        }
    }
    
    func notShowingValidEntry() {
        acceptButton.isEnabled = false
    }
    
    func showingValidEntry() {
        acceptButton.isEnabled = true
    }
    
    
}