import UIKit

class ScenarioLobbyViewController: UIViewController, NumPadViewDelegate {

    struct Constant {
        static let segueToScenarioID = "toScenarioVC"
        static let backgroundList = ["scenarioSetup", "scenarioSetup2", "scenarioSetup3", "scenarioSetup4"]
        static let scenarioNumpadColor = UIColor.flatRed()
    }
    
    @IBOutlet weak var viewBackgroundImage: UIImageView!
    
    @IBOutlet weak var setScenarioNumberContainerView: UIView!
    @IBOutlet weak var numPadContainerView: UIView!
    @IBOutlet weak var setScenarioLabel: UILabel!
    
    @IBOutlet weak var createScenarioButton: UIButton!
    
    @IBOutlet weak var setScenarioDifficultyContainerView: UIView!
    
    private var numPadView: NumPadView?
    private var scenario: Scenario?
    private var party: String?
    private var character: Character?
    private var service: ScenarioService?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewsOnLoad()
    }

    func configure(character: Character, party: String, service: ScenarioService) {
        self.party = party
        self.character = character
        self.service = service
    }
    
    func setupViewsOnLoad() {
        self.navigationController?.isNavigationBarHidden = true
        let random = Int(arc4random_uniform(4))
        viewBackgroundImage.image = UIImage(named: Constant.backgroundList[random])
        setScenarioNumberContainerView.isHidden = false
        setupNumPadView()
        setScenarioDifficultyContainerView.isHidden = true
    }
    
    @IBAction func createScenarioButtonTapped(_ sender: Any) {
        if let scenarioNumber = numPadView?.amountLabel.text {
            scenario = Scenario.scenarioFromNumber(scenarioNumber)
        }
        setScenarioNumberContainerView.isHidden = true
        setScenarioDifficultyContainerView.isHidden = false
    }
    
    @IBAction func difficultyNumberButtonTapped(_ sender: Any) {
        guard let difficulty = Int(((sender as! UIButton).titleLabel?.text)!) else { return }
        scenario?.difficulty = String(describing: difficulty)
        performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        guard let party = party else { return }
        service?.resetScenarioCreation(party: party)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func setupNumPadView() {
        numPadView = Bundle.main.loadNibNamed(String(describing: NumPadView.self), owner: self, options: nil)?.first as? NumPadView
        if let numPadView = numPadView {
            numPadContainerView.addSubview(numPadView)
            numPadView.frame = numPadContainerView.bounds
            numPadView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            numPadView.delegate = self
            numPadView.maxNumber = 95
            numPadView.digitsAllowed = 2
        }
        if let color = Constant.scenarioNumpadColor {
            numPadView?.setNumbersColor(color: color)
        }
    }
    
    func notShowingValidEntry() {
        createScenarioButton.isEnabled = false
    }
    
    func showingValidEntry() {
        createScenarioButton.isEnabled = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueToScenarioID {
            let destinationVC = segue.destination as! ScenarioViewController
            guard let party = party, let character = character, let scenario = scenario, let service = service else { return }
            destinationVC.configure(party: party, character: character, scenario: scenario, hosting: true, service: service)
        }
    }
}
