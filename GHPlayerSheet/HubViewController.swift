import UIKit

class HubViewController: UIViewController, UITextFieldDelegate {

    var characterClass = CharacterClass.cragheart
    var level = 0
    
    @IBOutlet weak var characterClassLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var levelButtons: [UIButton]!
    @IBOutlet weak var createButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        setDefaultLevelButtonsBackgrounds()
        createButton.titleLabel?.textColor = .lightGray
    }
    
    
    //MARK: - NameTextField and Keyboard delegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextField.keyboardType = .default
        textField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("done pressed")
        nameTextField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        toggleCreateButton()
        print("textField did end editing")
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
        print(level)
    }
    
    
    //MARK: - Create character button handling
    @IBAction func createCharacter(_ sender: Any) {
    }
    
    func toggleCreateButton(){
        if nameTextField.text != "" && level != 0 {
            print(nameTextField.text!)
            createButton.isEnabled = true
            createButton.titleLabel?.textColor = .blue
        } else {
            print("text field is empty")
            createButton.isEnabled = false
            createButton.titleLabel?.textColor = .lightGray
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterModel = CharacterModel(characterClass: characterClass, name: nameTextField.text!, level: level)
        let characterSheetVC = segue.destination as! CharacterSheetViewController
        characterSheetVC.characterModel = characterModel
    }
    

}
