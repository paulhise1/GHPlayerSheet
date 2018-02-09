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
    @IBOutlet weak var amountLabel: UILabel!
    
    private var experience: String?
    private var name: String?
    private var characterClass: CharacterClass.charClass?
    
    func configure(charClass: CharacterClass.charClass) {
        characterClass = charClass
        nameTextField.isHidden = true
        characterInfoLabel.isHidden = true
        acceptButton.isEnabled = false
        levelLabel.isHidden = true
        characterCreationLabel1.text = Constant.experienceLabel1
        characterCreationLabel2.text = Constant.experienceLabel2
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
        acceptButton.isEnabled = false
        experience = amountLabel.text
        numPadContainerView.isHidden = true
        nameTextField.isHidden = false
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        characterCreationLabel1.text = Constant.characterLabel1
        characterCreationLabel2.text = Constant.characterLabel2
        guard let xp = self.experience, let intXp = Int(xp) else { return }
        levelLabel.isHidden = false
        levelLabel.text = "Level \(Character.levelForExperience(experience: intXp))"
    }
    
    private func acceptEnteredName() {
        characterCreationLabel1.isHidden = true
        characterCreationLabel2.text = ""
        characterCreationLabel2.isHidden = true
        name = nameTextField.text
        levelLabel.isHidden = true
        nameTextField.isHidden = true
        guard let name = name, let xp = self.experience, let intXp = Int(xp), let charClass = characterClass?.rawValue else { return }
        characterInfoLabel.text = "\(name), A level \(Character.levelForExperience(experience: intXp)) \(charClass)"
        characterInfoLabel.isHidden = false
        acceptButton.setTitle(Constant.acceptButtonCreateTitle, for: .normal)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        name = nameTextField.text
        if name == "" {
            acceptButton.isEnabled = false
        } else {
            acceptButton.isEnabled = true
        }
    }

    @IBAction func numberButtonTapped(_ sender: UIButton) {
        var amount = amountLabel.text!
        if amount == "0" {
            amount = ""
            acceptButton.isEnabled = true
        }
        if amount.count < 3 {
            amount = amount + sender.titleLabel!.text!
            amountLabel.text = amount
        }
        if let amountInt = Int(amount) {
            if amountInt > 500 {
                amountLabel.text = "500"
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        var amount = amountLabel.text!
        amount = String(amount.dropLast())
        if amount == "" {
            amount = "0"
            acceptButton.isEnabled = false
        }
        amountLabel.text = amount
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.didCancelCharacterCreation()
    }
    
}
    

