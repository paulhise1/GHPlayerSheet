import UIKit

protocol HubNumPadDelegate: class {
    
}

class HubNumPadView: UIView {

    @IBOutlet weak var characterCreationLabel1: UILabel!
    @IBOutlet weak var characterCreationLabel2: UILabel!
    @IBOutlet weak var numPadContainerView: UIView!
    @IBOutlet weak var acceptButton: UIButton!
        {
        didSet {
            acceptButton.layer.cornerRadius = 6
            acceptButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var characterInfoLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    private var experience: String?
    private var name: String?
    private var characterClass: CharacterClass.charClass?
    
    func configure(){
        nameTextField.isHidden = true
        characterInfoLabel.isHidden = true
        acceptButton.isHidden = true
    }

 
    @IBAction func acceptButtonTapped(_ sender: Any) {
        if amountLabel.text != "0" {
            experience = amountLabel.text
            numPadContainerView.isHidden = true
            characterCreationLabel1.text = "Create A"
            characterCreationLabel2.text = "Character Name"
        } else if nameTextField.text != "" {
            name = nameTextField.text
            nameTextField.isHidden = true
            guard let name = name, let xp = self.experience, let intXp = Int(xp), let charClass = characterClass?.rawValue else { return }
            characterInfoLabel.text = "\(name), A level \(calculateLevel(experience: intXp)) \(charClass)"
            acceptButton.titleLabel?.text = "Create!"
        }
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        var amount = amountLabel.text!
        if amount == "0" {
            amount = ""
            acceptButton.isHidden = false
            if amount.count < 3 {
                amount = amount + sender.titleLabel!.text!
                amountLabel.text = amount
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        var amount = amountLabel.text!
        amount = String(amount.dropLast())
        if amount == "" {
            amount = "0"
            acceptButton.isHidden = true
        }
        amountLabel.text = amount
    }
    
    private func calculateLevel(experience: Int) -> String {
        switch experience {
        case 0...44:
            return "1"
        case 45...94:
            return "2"
        case 95...149:
            return "3"
        case 150...209:
            return "4"
        case 210...274:
            return "5"
        case 275...344:
            return "6"
        case 345...419:
            return "7"
        case 420...499:
            return "8"
        default:
            return "9"
        }
    }
}

extension HubNumPadView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        acceptButton.isHidden = false
    }
    
    
}
