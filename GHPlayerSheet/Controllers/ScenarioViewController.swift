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
    }
    
    @IBOutlet weak var selfNameLabel: UILabel!
    
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    @IBOutlet weak var lootTrackerContainerView: UIView!
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var noOtherPlayersLabel: UILabel!
    @IBOutlet var playerNameLabels: [UILabel]!
    @IBOutlet var playerHealthLabels: [UILabel]!
    @IBOutlet var playerExperienceLabels: [UILabel]!
    private var playerMaxHealths = [String]()
    
    @IBOutlet weak var playerStatStacksContainerView: UIView!
    @IBOutlet weak var player2StatStack: UIStackView!
    @IBOutlet weak var player3StatStack: UIStackView!
    @IBOutlet weak var player4StatStack: UIStackView!
    
    private var viewModel: ScenarioViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCounters()
        updateStackViews()
        updateScenario()
        setInfoOnLabels()
    }
   
    func configure(party: String, character: Character, scenario: Scenario?) {
        self.viewModel = ScenarioViewModel(party: party, character: character, scenario: scenario)
        self.viewModel?.delegate = self
    }
    
    func updateScenario() {
        guard let viewModel = viewModel else { return }
        viewModel.getScenario()
    }
    
    func setInfoOnLabels() {
        partyNameLabel.text = viewModel?.party
        selfNameLabel.text = viewModel?.player.name
        guard let scenarioNumber = viewModel?.scenario?.number, let scenarioName = viewModel?.scenario?.name else { return }
        scenarioTitleLabel.text = "\(scenarioNumber): \(scenarioName)"
        scenarioGoalLabel.text = viewModel?.scenario?.goal
    }
    
    func counterValueDidChange(value: String, type: CounterType) {
        switch type {
        case .health:
            viewModel?.updateCurrentHealth(value: value)
        case .experience:
            viewModel?.updateCurrentExperience(value: value)
        default:
            return
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
        guard let lootCounterView = Bundle.main.loadNibNamed(Constant.verticalCounterNibName, owner: self, options: nil)?.first as? CounterView else { return }
        lootCounterView.frame = lootTrackerContainerView.bounds
        lootCounterView.configure(counterType: .loot)
        lootTrackerContainerView.addSubview(lootCounterView)
        lootCounterView.delegate = self
    }
    
    func setupGenericCounterView() {
        guard let genericCounterView = Bundle.main.loadNibNamed(Constant.verticalCounterNibName, owner: self, options: nil)?.first as?CounterView else { return }
        genericCounterView.frame = genericTrackerContainerView.bounds
        genericCounterView.configure(counterType: .generic)
        genericTrackerContainerView.addSubview(genericCounterView)
        genericCounterView.delegate = self
    }
    
    func updateStackViews() {
        guard let viewModel = viewModel else { return }
        let count = viewModel.playerCount
        playerStatStacksContainerView.isHidden = !(count > 0)
        player2StatStack.isHidden = !(count > 0)
        player3StatStack.isHidden = !(count > 1)
        player4StatStack.isHidden = !(count > 2)
        noOtherPlayersLabel.isHidden = !(count == 0)
        displayPlayersData(players: viewModel.players)
    }
}

extension ScenarioViewController: ScenarioViewModelDelegate {
    
    func didUpdatePlayers() {
        guard (playerStatStacksContainerView) != nil else { return }
        updateStackViews()
    }
    
    func displayPlayersData(players: [ScenarioPlayer]) {
        var i = 0
        for player in players {
            playerNameLabels[i].text = player.name
            playerHealthLabels[i].text = ("\(player.health)/\(player.maxHealth)")
            playerExperienceLabels[i].text = player.experience
            i = i + 1
        }
    }
}
