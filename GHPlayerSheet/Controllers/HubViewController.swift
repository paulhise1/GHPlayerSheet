import UIKit

class HubViewController: UIViewController, HubViewModelDelegate {

    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioID = "toScenarioVC"
        static let partyScenarioLabelText = "Your party scenario:"
        
    }
    
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    @IBOutlet weak var classPickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var experienceTextField: UITextField!
    
    @IBOutlet weak var numpadContainerView: UIView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    @IBOutlet weak var partyScenarioInfoLabel1: UILabel!
    @IBOutlet weak var partyScenarioInfoLabel2: UILabel!
    @IBOutlet weak var joinScenarioButton: UIButton!
    
    private var viewModel: HubViewModel?
    
    private var selectedClass: CharacterClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()
        self.viewModel?.delegate = self
        
        self.numpadContainerView.isHidden = true
        
        self.classPickerView.delegate = self
        self.classPickerView.dataSource = self
        
        displayCharacterInfo()
        configureTextfields()
    }
    
    func displayCharacterInfo() {
        if let vm = viewModel {
            vm.loadCharacterFromPList()
            characterInfoLabel.text = vm.characterInfoForLabel()
        } else {
            characterInfoLabel.text = "Create a Character to get started!"
        }
    }
    
    @IBAction func createCharacterButtonTapped(_ sender: Any) {
        guard let charClass = selectedClass, let name = nameTextField.text, let xp = experienceTextField.text, let intXp = Int(xp) else { return }
        guard name != "" else { return }
        viewModel?.createCharacter(charClass: charClass, name: name, experience: intXp)
        displayCharacterInfo()
    }
    
    @IBAction func createScenarioButtonTapped(_ sender: Any) {
        numpadContainerView.isHidden = false
    }
    
    @IBAction func startScenarioButtonTapped(_ sender: Any) {
        guard let number = amountLabel.text else { return }
        viewModel?.startScenario(number: number)
        performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
    }
    
    @IBAction func joinScenarioButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
    }
    
    func updateScenarioInfo(scenarioLabelText: String) {
        partyScenarioInfoLabel1.text = Constant.partyScenarioLabelText
        partyScenarioInfoLabel2.text = scenarioLabelText
    }
    
    @IBAction func characterSheetButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Constant.segueToCharacterSheetID, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vm = viewModel, let charDatasource = vm.characterDatasource else { return }
        if segue.identifier == Constant.segueToCharacterSheetID {
            let destinationVC = segue.destination as? CharacterSheetViewController
            destinationVC?.configure(characterDataSource: charDatasource)
            
            
        } else if segue.identifier == Constant.segueToScenarioID {
            let destinationVC = segue.destination as? ScenarioViewController
            destinationVC?.configure(name: vm.name, health: vm.health, scenerioService: vm.scenarioService, partyName: vm.partyName, playerName: vm.name)
        }
    }
    
    //MARK: - Number Pad Methods
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        var amount = amountLabel.text!
        if amount == "0" {
            amount = ""
        }
        if amount.count < 2 {
            amount = amount + sender.titleLabel!.text!
            amountLabel.text = amount
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        var amount = amountLabel.text!
        amount = String(amount.dropLast())
        if amount == "" {
            amount = "0"
        }
        amountLabel.text = amount
    }
}

extension HubViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let number = viewModel?.characterClassCount ?? 0
        return number
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let charClass = viewModel?.characterClassAt(index: row) else {
            return
        }
        selectedClass = charClass
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = viewModel?.characterClassAttributedStringAt(index: row) ?? nil
        return title
    }
    
    func configureTextfields() {
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        experienceTextField.delegate = self
        experienceTextField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameTextField.isFirstResponder {
            experienceTextField.becomeFirstResponder()
        } else if experienceTextField.isFirstResponder {
         experienceTextField.resignFirstResponder()
        }
        return true
    }
}
