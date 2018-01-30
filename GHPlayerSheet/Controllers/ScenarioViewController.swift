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
    
    private let partyName = "The Funk Hunters"
    
    @IBOutlet weak var noOtherPlayersLabel: UILabel!
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    
    @IBOutlet var playerNameLabels: [UILabel]!
    @IBOutlet var playerHealthLabels: [UILabel]!
    @IBOutlet var playerExperienceLabels: [UILabel]!
    private var playerMaxHealths = [String]()
    
    @IBOutlet weak var player2StatStack: UIStackView!
    @IBOutlet weak var player3StatStack: UIStackView!
    @IBOutlet weak var player4StatStack: UIStackView!
    @IBOutlet weak var connectedWithLabel: UILabel!
    
    private var viewModel: ScenarioViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //TODO: remove default values...only for prototype
    func configure(name: String = UIDevice.current.name, health: String = "0") {
        
        self.viewModel = ScenarioViewModel(name: name, maxHealth: health, service: FirebaseService())
        self.viewModel?.delegate = self
        
        setupCounters()
        updateStackViews()
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
        noOtherPlayersLabel.isHidden = count == 0
        player2StatStack.isHidden = !(count > 0)
        player3StatStack.isHidden = !(count > 1)
        player4StatStack.isHidden = !(count > 2)
    }
    
}

extension ScenarioViewController: ScenarioViewModelDelegate {
    func didUpdatePlayers(players: [Player]) {
        // update the individual player views with their new models
    }
}
