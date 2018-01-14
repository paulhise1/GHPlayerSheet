import UIKit

class HubViewController: UIViewController, UITextFieldDelegate {

    var characterClass = CharacterClass.cragheart
    var level = 0
    
    @IBOutlet weak var characterClassLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var levelButtons: [UIButton]!
    @IBOutlet weak var createCharacterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        setDefaultLevelButtonsBackgrounds()
        setCreateCharacterButton()
    }
    
    
    //MARK: - NameTextField and Keyboard delegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextField.keyboardType = .default
        textField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        toggleCreateButton()
    }
    
    
    //MARK: - Set character level buttons handling
    
    func setDefaultLevelButtonsBackgrounds(){
        for button in levelButtons {
            button.backgroundColor = .blue
        }
    }
    
    @IBAction func levelButtonTapped(_ sender: UIButton) {
        setDefaultLevelButtonsBackgrounds()
        sender.backgroundColor = .orange
        if let buttonNumber = sender.titleLabel?.text {
            level = Int(buttonNumber)!
        }
        toggleCreateButton()
    }
    
    
    //MARK: - Create button handling
    
    @IBAction func createCharacterTapped(_ sender: Any) {
    }
    
    func toggleCreateButton(){
        if nameTextField.text != "" && level != 0 {
            createCharacterButton.isEnabled = true
        } else {
            createCharacterButton.isEnabled = false
        }
    }
    
    func setCreateCharacterButton(){
        createCharacterButton.setTitleColor(UIColor.gray, for: .disabled)
        toggleCreateButton()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterModel = CharacterModel(characterClass: characterClass, name: nameTextField.text!, level: level)
        let characterSheetVC = segue.destination as! CharacterSheetViewController
        characterSheetVC.characterModel = characterModel
    }
    

}
