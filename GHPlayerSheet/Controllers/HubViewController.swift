import UIKit

class HubViewController: UIViewController, HubViewModelDelegate {

    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioID = "toScenarioVC"
        static let partyScenarioLabelText = "Your party scenario:"
        
    }
    
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    @IBOutlet weak var toCharacterSheetButton: UIButton! {
        didSet {
            toCharacterSheetButton.layer.cornerRadius = 4
            toCharacterSheetButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var createCharacterContainerView: UIView!
    @IBOutlet weak var classPickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var experienceButton: UIButton! {
        didSet {
            experienceButton.layer.cornerRadius = 4
            experienceButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var newCharacterButton: UIButton! {
        didSet {
            newCharacterButton.layer.cornerRadius = 4
            newCharacterButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var acceptCharacterButton: UIButton! {
        didSet {
            acceptCharacterButton.layer.cornerRadius = 4
            acceptCharacterButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var numpadContainerView: UIView!
        {
        didSet {
            numpadContainerView.layer.cornerRadius = 4
            numpadContainerView.layer.masksToBounds = true
         }
    }
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var numpadLabelView: UILabel!
    @IBOutlet weak var numpadAcceptButton: UIButton!
    
    @IBOutlet weak var createPartyButton: UIButton! {
        didSet {
            createPartyButton.layer.cornerRadius = 4
            createPartyButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var newPartyButton: UIButton! {
        didSet {
            newPartyButton.layer.cornerRadius = 4
            newPartyButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var scenarioInfoLabelContainerView: UIView!
    @IBOutlet weak var partyScenarioInfoLabel1: UILabel!
    @IBOutlet weak var partyScenarioInfoLabel2: UILabel!
    @IBOutlet weak var newScenarioButton: UIButton! {
        didSet {
            newScenarioButton.layer.cornerRadius = 4
            newScenarioButton.layer.masksToBounds = true

        }
    }
    @IBOutlet weak var joinScenarioButton: UIButton! {
        didSet {
            joinScenarioButton.layer.cornerRadius = 4
            joinScenarioButton.layer.masksToBounds = true
        }
    }
    
    private var viewModel: HubViewModel?
    
    private var selectedClass: CharacterClass?
    private var experience: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()
        self.viewModel?.delegate = self
        
        self.numpadContainerView.isHidden = true
        
        self.classPickerView.delegate = self
        self.classPickerView.dataSource = self
        
        configureViews()
        configureTextfields()
        displayCharacterInfo()
    }
    
    func configureViews(){
        scenarioInfoLabelContainerView.isHidden = true
        createCharacterContainerView.isHidden = true
        newPartyButton.isHidden = true
        createPartyButton.isHidden = true
        joinScenarioButton.isEnabled = false
    }
    
    func displayCharacterInfo() {
        guard let vm = viewModel else { return }
        vm.scenarioService.scenarioInfo()
        vm.loadCharacterFromPList()
        characterInfoLabel.text = vm.characterInfoForLabel()
        guard let party = vm.partyName else {
            partyNameLabel.isHidden = true
            createPartyButton.isHidden = false
            newPartyButton.isHidden = true
            return
        }
        
        partyNameLabel.text = party
        partyNameLabel.isHidden = false
        createPartyButton.isHidden = true
        newPartyButton.isHidden = false
    }
    
    func setPartyName(partyName: String) {
        viewModel?.updateParty(partyname: partyName)
        displayCharacterInfo()
    }
    
    @IBAction func createCharacterButtonTapped(_ sender: Any) {
        guard let charClass = selectedClass, let name = nameTextField.text, !name.isEmpty, let xp = experience, let intXp = Int(xp) else { return }
        viewModel?.createCharacter(charClass: charClass, name: name, experience: intXp)
        displayCharacterInfo()
        createCharacterContainerView.isHidden = true
        newCharacterButton.isHidden = false
        toCharacterSheetButton.isHidden = false
    }
    
    @IBAction func addCharacterButtonTapped(_ sender: Any) {
        createCharacterContainerView.isHidden = false
        newCharacterButton.isHidden = true
        toCharacterSheetButton.isHidden = true
    }
    
    @IBAction func createPartyButtonTapped(_ sender: Any) {
        //stub
        let party = "The Funk Hunters"
        setPartyName(partyName: party)
    }
    
    @IBAction func createScenarioButtonTapped(_ sender: Any) {
        numpadContainerView.isHidden = false
        amountLabel.text = "0"
        numpadLabelView.text = "Enter Scenario Number"
        numpadAcceptButton.setTitle("Start Scenario", for: .normal)
    }
    
    @IBAction func experienceButtonTapped(_ sender: Any) {
        numpadContainerView.isHidden = false
        amountLabel.text = "0"
        numpadLabelView.text = "Enter Total Experience"
        numpadAcceptButton.setTitle("Accept", for: .normal)
    }
    
    @IBAction func numpadAcceptButtonTapped(_ sender: Any) {
        guard let number = amountLabel.text else { return }
        if numpadAcceptButton.titleLabel?.text == "Start Scenario" {
            viewModel?.startScenario(number: number)
            performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
        } else if numpadAcceptButton.titleLabel?.text == "Accept" {
            experienceButton.setTitle(number, for: .normal)
            experience = number
            numpadContainerView.isHidden = true
        }
    }
    
    @IBAction func joinScenarioButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
    }
    
    func updateScenarioInfo(scenarioLabelText: String) {
        createPartyButton.isHidden = true
        joinScenarioButton.isEnabled = true
        newPartyButton.isHidden = false
        scenarioInfoLabelContainerView.isHidden = false
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
            guard let party = vm.partyName else { return }
            let destinationVC = segue.destination as? ScenarioViewController
            destinationVC?.configure(name: vm.name, health: vm.health, scenerioService: vm.scenarioService, partyName: party, playerName: vm.name)
        }
    }
    
    //MARK: - Number Pad Methods
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        var amount = amountLabel.text!
        if amount == "0" {
            amount = ""
        }
        if numpadAcceptButton.titleLabel?.text == "Start Scenario" {
            if amount.count < 2 {
                amount = amount + sender.titleLabel!.text!
                amountLabel.text = amount
            }
        } else if numpadAcceptButton.titleLabel?.text == "Accept" {
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = UIColor.flatBlackColorDark()
        label.font = UIFont(name: "HighTowerText-Reg" , size: 20)
        label.text = viewModel?.characterClassStringAt(index: row)
        label.textAlignment = .center
        return label
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let title = viewModel?.characterClassStringAt(index: row) ?? nil
//        return title
//    }
    
    func configureTextfields() {
        nameTextField.delegate = self
        nameTextField.keyboardType = .asciiCapable
        nameTextField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
