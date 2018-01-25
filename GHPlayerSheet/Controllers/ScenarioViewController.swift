import UIKit
import MultipeerConnectivity

enum StatUpdateType {
    case name(String)
    case health(String)
    case experience(String)
}

struct MPCConstants {
    static let healthStatType = "health"
    static let experienceStatType = "experience"
    static let nameStatType = "name"
    static let verticalCounterNibName = "VerticalCounterView"
    static let horizontalCounterNibName = "HorizontalCounterView"
    static let statTypeKey = "statType"
    static let valueKey = "value"
    static let mPCServicType = "ghscenario"
    static let maxHealth = "maxHealth"
}

class ScenarioViewController: UIViewController, CounterViewDelegate, ScenarioShareManagerDelegate {
    
    private var maxHealth: String?
    private var currentHealth: String?
    private var name: String?
    private var scenarioShareManager: ScenarioShareManager?
    private var currentExperience = "0"
    
    @IBOutlet weak var noOtherPlayersLabel: UILabel!
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    
    private var players = [String]()
    
    @IBOutlet var playerNameLabels: [UILabel]!
    @IBOutlet var playerHealthLabels: [UILabel]!
    @IBOutlet var playerExperienceLabels: [UILabel]!
    private var playerMaxHealths = [String]()
    
    @IBOutlet weak var player2StatStack: UIStackView!
    @IBOutlet weak var player3StatStack: UIStackView!
    @IBOutlet weak var player4StatStack: UIStackView!
    @IBOutlet weak var connectedWithLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //TODO: remove default values...only for prototype
    func configure(name: String = UIDevice.current.name, health: String = "15") {
        self.name = name
        self.maxHealth = health
        self.currentHealth = health
        scenarioShareManager = ScenarioShareManager(displayName: name, maxHealth: health)
        scenarioShareManager?.delegate = self
        
        setupCounters()
        updateStackViews()
    }
    
    func counterValueDidChange(value: String, type: CounterType) {
        var statType: String?
        switch type {
        case .health:
            currentHealth = value
            statType = MPCConstants.healthStatType
        case .experience:
            currentExperience = value
            statType = MPCConstants.experienceStatType
        default:
            return
        }
        scenarioShareManager?.broadcastStatUpdate(statType: statType!, value: value)
    }
    
    func didRecieveInvitationFromPeer(displayName: String, maxHealth: String) {
        print("@@@@GotInvite \(displayName): connectionTest")

        if !self.players.contains(displayName) {
            self.players.append(displayName)
            self.playerMaxHealths.append(maxHealth)
            // Perhaps study behavior of this on didSet of players[]
            self.updateStackViews()
            //
            if let index = self.players.index(of: displayName) {
                self.playerNameLabels[index].text = displayName
            }
        }
    }
    
    func didReceiveNewStat(type: StatUpdateType, displayName: String) {
        OperationQueue.main.addOperation {
            switch type {
            case .health(let value):
                if let index = self.players.index(of: displayName) {
                    self.playerHealthLabels[index].text = value
                }
            case .experience(let value):
                if let index = self.players.index(of: displayName) {
                    self.playerExperienceLabels[index].text = value
                }
            case .name(let value):
                if let index = self.players.index(of: displayName) {
                    self.playerNameLabels[index].text = value
                }
            }
        }
    }
    
    //MARK:- MCScenarioShare delegates to register stat changes.
    func deviceConnectionDidChange(state: MCSessionState, displayName: String, peers: [MCPeerID]) {
        OperationQueue.main.addOperation {
            switch state {
            case .connected:
                self.updateNewlyConnectedPlayer()
                self.connectedWithLabel.text = self.connectedPeersString(connectedWith: peers)
                if let index = self.players.index(of: displayName) {
                    print("^^^^connected   - updating \(self.players[index]))      connectionTest")
                    self.updatePlayersVisualConnectionStatus(state: state, index: index)
                }
            case .notConnected:
                if let index = self.players.index(of: displayName) {
                    print("****disconnected - updating \(self.players[index]))      connectionTest")
                    self.updatePlayersVisualConnectionStatus(state: state, index: index)
                }
                //NOTE:Debug Label
                self.connectedWithLabel.text = self.connectedPeersString(connectedWith: peers)
            case.connecting:
                print("????Connecting\(displayName): connectionTest")
                return
            }
        }
    }
    
    func updateNewlyConnectedPlayer() {
        if let currentHealth = currentHealth {
            scenarioShareManager?.broadcastStatUpdate(statType: MPCConstants.healthStatType, value: currentHealth)
            scenarioShareManager?.broadcastStatUpdate(statType: MPCConstants.experienceStatType, value: currentExperience)
        }
    }
    
    func updatePlayersVisualConnectionStatus(state: MCSessionState, index: Int) {
        self.playerNameLabels[index].backgroundColor = state == MCSessionState.connected ? ColorConstants.connectedPlayerBackground : ColorConstants.disconnectedPlayerBackground
        self.playerNameLabels[index].textColor = state == MCSessionState.connected ? ColorConstants.connectedPlayerText : ColorConstants.disconnectedPlayerText
    }
    
    func updateStackViews() {
        noOtherPlayersLabel.isHidden = players.count == 0
        player2StatStack.isHidden = !(players.count > 0)
        player3StatStack.isHidden = !(players.count > 1)
        player4StatStack.isHidden = !(players.count > 2)
    }
    
    // NOTE: helper function for debugging
    func connectedPeersString(connectedWith: [MCPeerID]) -> String {
        var connectedWithString = "Connected to:"
        for peer in connectedWith {
            let peerName = peer.displayName
            connectedWithString =  connectedWithString + "  " + "\(peerName),"
        }
        return connectedWithString
    }
    
    //MARK: - Setup Child Views
    func setupCounters() {
        setupHealthCounterView()
        setupExperienceCounterView()
        setupGenericCounterView()
    }
    
    func setupHealthCounterView() {
        let healthCounterView = Bundle.main.loadNibNamed(MPCConstants.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView
        healthCounterView?.frame = healthTrackerContainerView.bounds
        let currentHealth = self.currentHealth ?? "0"
        healthCounterView?.configure(value: currentHealth, counterType: .health, maxValue: maxHealth)
        healthTrackerContainerView.addSubview(healthCounterView!)
        healthCounterView?.delegate = self
    }
    
    func setupExperienceCounterView() {
        let experienceCounterView = Bundle.main.loadNibNamed(MPCConstants.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView
        experienceCounterView?.frame = experienceTrackerContainerView.bounds
        experienceCounterView?.configure(value: currentExperience, counterType: CounterType.experience)
        experienceTrackerContainerView.addSubview(experienceCounterView!)
        experienceCounterView?.delegate = self
    }
    
    func setupGenericCounterView() {
        let genericCounterView = Bundle.main.loadNibNamed(MPCConstants.verticalCounterNibName, owner: self, options: nil)?.first as?CounterView
        genericCounterView?.frame = genericTrackerContainerView.bounds
        genericCounterView?.configure(value: "0", counterType: CounterType.generic)
        genericTrackerContainerView.addSubview(genericCounterView!)
        genericCounterView?.delegate = self
    }
    
}


