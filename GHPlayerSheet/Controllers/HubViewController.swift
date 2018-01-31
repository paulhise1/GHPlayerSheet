import UIKit

class HubViewController: UIViewController, HubViewModelDelegate {

    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioID = "toScenarioViewController"
        static let partyScenarioLabelText = "Your party scenario:"
        
    }
    
    @IBOutlet weak var numpadContainerView: UIView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    @IBOutlet weak var partyScenarioInfoLabel1: UILabel!
    @IBOutlet weak var partyScenarioInfoLabel2: UILabel!
    @IBOutlet weak var joinScenarioButton: UIButton!
    
    private var viewModel: HubViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()
        self.viewModel?.delegate = self
        
        self.numpadContainerView.isHidden = true
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueToCharacterSheetID {
            // things to do before character sheet segue
        } else if segue.identifier == Constant.segueToScenarioID {
            guard let vm = viewModel else { return }
            let destinationVC = segue.destination as? ScenarioViewController
            destinationVC?.configure(name: vm.name, health: vm.health, scenerioService: vm.scenarioService)
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
