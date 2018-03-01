import UIKit

enum StatUpdateType {
    case name(String)
    case health(String)
    case experience(String)
}

class ScenarioViewController: UIViewController, CounterViewDelegate {
    
    struct Constant {
        static let verticalCounterNibName = "VerticalCounterView"
        static let horizontalCounterNibName = "HorizontalCounterView"
        static let toHubVCSegueID = "toHubVC"
        static let checkedBox = "checkedBoxGreen"
        static let emptyBox = "emptyBoxGreen"
    }
    
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var scenarioDifficultyLabel: UILabel!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet var playerNameLabels: [UILabel]!
    @IBOutlet var playerHealthLabels: [UILabel]!
    @IBOutlet var playerMaxHealthLabels: [UILabel]!
    
    @IBOutlet var playerExperienceLabels: [UILabel]!
    @IBOutlet var playerLootLabels: [UILabel]!
    private var playerMaxHealths = [String]()
    
    @IBOutlet weak var player2StatStack: UIStackView!
    @IBOutlet weak var player3StatStack: UIStackView!
    @IBOutlet weak var player4StatStack: UIStackView!
    
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var lootTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    
    @IBOutlet weak var endScenarioViewContainer: UIView!
    
    @IBOutlet weak var battlemarkLeftButton: UIButton!
    @IBOutlet weak var battlemarkRightButton: UIButton!
    @IBOutlet weak var checkboxContainer: UIView! {
        didSet {
            checkboxContainer.layer.cornerRadius = 6
            checkboxContainer.layer.masksToBounds = true
        }
    }
    
    private var viewModel: ScenarioViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCounters()
        updateStackViews()
        setInfoOnLabels()
    }
   
    func configure(party: String, character: Character, scenario: Scenario, hosting: Bool, service: ScenarioService) {
        self.viewModel = ScenarioViewModel(party: party, character: character, scenario: scenario, hosting: hosting, service: service)
        self.viewModel?.delegate = self
    }
    
    func setInfoOnLabels() {
        guard let viewModel = viewModel else { return }
        partyNameLabel.text = " \(viewModel.party) "
        playerNameLabel.text = viewModel.player.name
        scenarioTitleLabel.text = "# \(viewModel.scenario.number): \(viewModel.scenario.name)"
        scenarioGoalLabel.text = viewModel.scenario.goal
        scenarioDifficultyLabel.text = viewModel.scenario.difficulty
    }
    
    func counterValueDidChange(value: String, type: CounterType) {
        switch type {
        case .health:
            viewModel?.updateCurrentHealth(value: value)
        case .experience:
            viewModel?.updateCurrentExperience(value: value)
        case .loot:
            viewModel?.updateCurrentLoot(value: value)
        default:
            return
        }
    }
    @IBAction func endScenarioButtonTapped(_ sender: Any) {
        setupEndScenarioView()
    }
    
    @IBAction func battlemarkLeftButtonTapped(_ sender: Any) {
        if viewModel?.player.battlemarks == "0" {
            battlemarkLeftButton.setImage(UIImage(named: Constant.checkedBox), for: .normal)
            viewModel?.updateBattlemarkCount("1")
            battlemarkRightButton.isEnabled = true
        } else if viewModel?.player.battlemarks == "1" {
            battlemarkLeftButton.setImage(UIImage(named: Constant.emptyBox), for: .normal)
            viewModel?.updateBattlemarkCount("0")
            battlemarkRightButton.isEnabled = false
        }
    }
    
    @IBAction func battlemarkRightButtonTapped(_ sender: Any) {
        if viewModel?.player.battlemarks == "1" {
            battlemarkRightButton.setImage(UIImage(named: Constant.checkedBox), for: .normal)
            viewModel?.updateBattlemarkCount("2")
            battlemarkLeftButton.isEnabled = false
        } else if viewModel?.player.battlemarks == "2" {
            battlemarkRightButton.setImage(UIImage(named: Constant.emptyBox), for: .normal)
            viewModel?.updateBattlemarkCount("1")
            battlemarkLeftButton.isEnabled = true
        }
    }
    
    //MARK: - Setup Child Views
    func setupCounters() {
        guard let viewmodel = self.viewModel else { return }
        setupHealthCounterView(health: viewmodel.player.maxHealth)
        setupExperienceCounterView()
        setupGenericCounterView()
        setupLootCounterView()
    }
    
    func setupHealthCounterView(health: String) {
        guard let healthCounterView = Bundle.main.loadNibNamed(Constant.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView else { return }
        healthCounterView.frame = healthTrackerContainerView.bounds
        healthCounterView.configure(value: health, counterType: .health, maxValue: health)
        healthTrackerContainerView.addSubview(healthCounterView)
        healthCounterView.delegate = self
    }
    
    func setupExperienceCounterView() {
        guard let experienceCounterView = Bundle.main.loadNibNamed(Constant.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView else { return }
        experienceCounterView.frame = experienceTrackerContainerView.bounds
        experienceCounterView.configure(counterType: .experience)
        experienceTrackerContainerView.addSubview(experienceCounterView)
        experienceCounterView.delegate = self
    }
    
    func setupLootCounterView() {
        guard let lootCounterView = Bundle.main.loadNibNamed(Constant.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView else { return }
        lootCounterView.frame = lootTrackerContainerView.bounds
        lootCounterView.configure(counterType: .loot)
        lootTrackerContainerView.addSubview(lootCounterView)
        lootCounterView.delegate = self
    }
    
    func setupGenericCounterView() {
        guard let genericCounterView = Bundle.main.loadNibNamed(Constant.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView else { return }
        genericCounterView.frame = genericTrackerContainerView.bounds
        genericCounterView.configure(counterType: .generic)
        genericTrackerContainerView.addSubview(genericCounterView)
        genericCounterView.delegate = self
    }
    
    func setupEndScenarioView() {
        view.bringSubview(toFront: endScenarioViewContainer)
        guard let endScenarioView = Bundle.main.loadNibNamed(String(describing: EndScenarioView.self), owner: self, options: nil)?.first as? EndScenarioView, let loot = viewModel?.player.loot, let experience = viewModel?.player.experience, let difficulty = viewModel?.scenario.difficulty, let battlemarks = viewModel?.player.battlemarks else { return }
        endScenarioView.frame = endScenarioViewContainer.bounds
        endScenarioViewContainer.addSubview(endScenarioView)
        endScenarioView.configure(lootCount: loot, experienceCount: experience, difficulty: difficulty, battlemarks: battlemarks)
        endScenarioView.delegate = self
    }
    
    func updateStackViews() {
        guard let viewModel = viewModel else { return }
        let count = viewModel.playerCount
        player2StatStack.isHidden = !(count > 0)
        player3StatStack.isHidden = !(count > 1)
        player4StatStack.isHidden = !(count > 2)
        displayPlayersData(players: viewModel.players)
    }
}

extension ScenarioViewController: ScenarioViewModelDelegate {
    
    func didUpdatePlayers() {
        if player2StatStack != nil {
            updateStackViews()
        }
    }
    
    func displayPlayersData(players: [ScenarioPlayer]) {
        for (i, player) in players.enumerated() {
            playerNameLabels[i].text = player.name
            playerHealthLabels[i].text = player.health
            playerExperienceLabels[i].text = player.experience
            playerLootLabels[i].text = player.loot
            if player.health == player.maxHealth {
                playerMaxHealthLabels[i].isHidden = true
                playerHealthLabels[i].textColor = ColorConstants.healthBackgroundColor
            } else {
                playerMaxHealthLabels[i].isHidden = false
                playerHealthLabels[i].textColor = ColorConstants.healthCounterColor
                playerMaxHealthLabels[i].text = player.maxHealth
            }
        }
    }
}

extension ScenarioViewController: EndScenarioViewDelegate {
    func scenarioOutcomeIfPresent() -> Bool? {
        return viewModel?.scenarioOutcome()
    }
    
    func didEndScenario(success: Bool) {
        viewModel?.endScenario(success: success)
    }
    
    func cleanupEndedScenario(gold: Int, experience: Int, battlemarks: Int) {
        viewModel?.cleanupEndedScenario(gold: gold, experience: experience, battlemarks: battlemarks)
        navigationController?.popToRootViewController(animated: true)
    }
}
