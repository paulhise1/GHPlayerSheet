import UIKit

class ScenarioLobbyViewController: UIViewController, NumPadViewDelegate {

    struct Constant {
        static let segueToScenarioID = "toScenarioVC"
        static let backgroundList = ["scenarioSetup", "scenarioSetup2", "scenarioSetup3", "scenarioSetup4"]
        static let scenarioNumpadColor = UIColor.flatRed()
    }
    
    @IBOutlet weak var viewBackgroundImage: UIImageView!
    
    @IBOutlet weak var setScenarioContainerView: UIView!
    @IBOutlet weak var numPadContainerView: UIView!
    @IBOutlet weak var setScenarioLabel: UILabel!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var createScenarioButton: UIButton!
    
    @IBOutlet weak var setDifficultyLevelContainerView: UIView!
    
    private var numPadView: NumPadView?
    private var scenario: Scenario?
    private var party: String?
    private var character: Character?
    private var difficulty: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewsOnLoad()
    }

    func configure(character: Character, party: String) {
        self.party = party
        //stubb
        self.character = Character(classType: .brute, name: "Bob Tucket")
        character.updateExperience(amount: 222)
    }
    
    func setupViewsOnLoad() {
        self.navigationController?.isNavigationBarHidden = true
        let random = Int(arc4random_uniform(4))
        viewBackgroundImage.image = UIImage(named: Constant.backgroundList[random])
        setScenarioContainerView.isHidden = true
        setDifficultyLevelContainerView.isHidden = true
    }
    
    @IBAction func setTheTableTapped(_ sender: Any) {
        buttonStackView.isHidden = true
        setScenarioContainerView.isHidden = false
        setScenarioLabel.isHidden = false
        setupNumPadView()
    }
    @IBAction func createScenarioButtonTapped(_ sender: Any) {
        if let scenarioNumber = numPadView?.amountLabel.text {
            scenario = Scenario.scenarioFromNumber(scenarioNumber)
        }
        setScenarioContainerView.isHidden = true
        setDifficultyLevelContainerView.isHidden = false
    }
    
    @IBAction func difficultyNumberButtonTapped(_ sender: Any) {
        difficulty = Int(((sender as! UIButton).titleLabel?.text)!)
        performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
    }
    
    @IBAction func joinTheTableTapped(_ sender: Any) {
    }
    
    @IBAction func ReturnButtonTapped(_ sender: Any) {
    }
    @IBAction func backButtonTapped(_ sender: Any) {
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
//            let destinationVC = segue.destination as! ScenarioViewController
//            guard let party = party, let character = character else { return }
//            destinationVC.configure(partyName: party, character: character, scenario: scenario, difficulty: difficulty)
        }
    }
}
