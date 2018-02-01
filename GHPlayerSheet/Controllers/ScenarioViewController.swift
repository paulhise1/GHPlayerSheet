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
    }
    
    @IBOutlet weak var selfNameLabel: UILabel!
    
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    
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
    }
    
    func configure(name: String, health: String, scenerioService: ScenarioService) {
        self.viewModel = ScenarioViewModel(name: name, maxHealth: health, service: scenerioService)
        self.viewModel?.delegate = self
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        //go back to hub screen.
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
        setupHealthCounterView()
        setupExperienceCounterView()
        setupGenericCounterView()
    }
    
    func setupHealthCounterView() {
        guard let healthCounterView = Bundle.main.loadNibNamed(Constant.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView, let vm = viewModel else { return }
        healthCounterView.frame = healthTrackerContainerView.bounds
        healthCounterView.configure(value: vm.currentHealth, counterType: .health, maxValue: vm.maxHealth)
        healthTrackerContainerView.addSubview(healthCounterView)
        healthCounterView.delegate = self
    }
    
    func setupExperienceCounterView() {
        guard let experienceCounterView = Bundle.main.loadNibNamed(Constant.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView, let vm = viewModel else { return }
        experienceCounterView.frame = experienceTrackerContainerView.bounds
        experienceCounterView.configure(value: vm.currentExperience, counterType: CounterType.experience)
        experienceTrackerContainerView.addSubview(experienceCounterView)
        experienceCounterView.delegate = self
    }
    
    func setupGenericCounterView() {
        guard let genericCounterView = Bundle.main.loadNibNamed(Constant.verticalCounterNibName, owner: self, options: nil)?.first as?CounterView else { return }
        genericCounterView.frame = genericTrackerContainerView.bounds
        genericCounterView.configure(value: "0", counterType: CounterType.generic)
        genericTrackerContainerView.addSubview(genericCounterView)
        genericCounterView.delegate = self
    }
    
    func updateStackViews() {
        guard let count = viewModel?.playerCount else { return }
        player2StatStack.isHidden = !(count > 0)
        playerStatStacksContainerView.isHidden = !(count > 0)
        player3StatStack.isHidden = !(count > 1)
        player4StatStack.isHidden = !(count > 2)
        noOtherPlayersLabel.isHidden = !(count == 0)
    }
    
}

extension ScenarioViewController: ScenarioViewModelDelegate {
    func didUpdatePlayers(players: [Player]) {
        updateStackViews()
        displayPlayersData(players: players)
    }
    
    func displayPlayersData(players: [Player]) {
        var i = 0
        for player in players {
            playerNameLabels[i].text = player.name
            playerHealthLabels[i].text = ("\(player.health)/\(player.maxHealth)")
            playerExperienceLabels[i].text = player.experience
            i = i + 1
        }
    }
    
    func setupLabelsForScenario(name: String, goal: String) {
        scenarioTitleLabel.text = name
        scenarioGoalLabel.text = goal
    }
}




