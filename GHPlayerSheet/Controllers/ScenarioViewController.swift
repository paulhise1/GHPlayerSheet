import UIKit
import MultipeerConnectivity

enum StatUpdateType {
    case name
    case health
    case experience
}

struct Constants {
    static let healthStatType = "health"
    static let experienceStatType = "experience"
    static let nameStatType = "name"
    static let verticalCounterNibName = "VerticalCounterView"
    static let horizontalCounterNibName = "HorizontalCounterView"
    static let statTypeKey = "statType"
    static let valueKey = "value"
    static let mPCServicType = "ghscenario"
}

class ScenarioViewController: UIViewController, CounterViewDelegate, ScenarioShareManagerDelegate {
    
    private let scenarioShareManager = ScenarioShareManager()
    private var currentHealth = 0
    private var currentExperience = 0
   
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
    
    @IBOutlet weak var player2StatStack: UIStackView!
    @IBOutlet weak var player3StatStack: UIStackView!
    @IBOutlet weak var player4StatStack: UIStackView!
    @IBOutlet weak var connectedWithLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scenarioShareManager.delegate = self
        setupCounters()
        updateStackViews()
    }
  
    func counterValueDidChange(value: Int, type: CounterType) {
        let stringValue = String(value)
        var statType: String?
        switch type {
        case .health:
            currentHealth = value
            statType = Constants.healthStatType
        case .experience:
            currentExperience = value
            statType = Constants.experienceStatType
        default:
            return
        }
        scenarioShareManager.broadcastStatUpdate(statType: statType!, value: stringValue)
    }
    
    func recievedStatChanged(statType: StatUpdateType, value: String, displayName: String) {
        OperationQueue.main.addOperation {
            switch statType {
            case .health:
                if let index = self.players.index(of: displayName) {
                    self.playerHealthLabels[index].text = value
                }
            case .experience:
                if let index = self.players.index(of: displayName) {
                    self.playerExperienceLabels[index].text = value
                }
            case .name:
                if let index = self.players.index(of: displayName) {
                    self.playerNameLabels[index].text = value
                }
            }
        }
    }
    
    //MARK:- MCScenarioShare delegates to register stat changes.
    func deviceConnectionStateChanged(displayName: String, state: MCSessionState, peers: [MCPeerID]) {
        OperationQueue.main.addOperation {
            
            
            
            switch state {
            case .connected:
                if !self.players.contains(displayName) {
                    self.players.append(displayName)
                    self.updateStackViews()
                    if let index = self.players.index(of: displayName) {
                        self.playerNameLabels[index].text = displayName
                    }
                }
                self.updateNewlyConnectedPlayer()
                self.connectedWithLabel.text = self.connectedPeersString(connectedWith: peers)
                if let index = self.players.index(of: displayName) {
                    self.updatePlayersVisualConnectionStatus(state: state, index: index)
                }
            case .notConnected:
                if let index = self.players.index(of: displayName) {
                    self.updatePlayersVisualConnectionStatus(state: state, index: index)
                }
                self.connectedWithLabel.text = self.connectedPeersString(connectedWith: peers)
                if let index = self.players.index(of: displayName) {
                    self.updatePlayersVisualConnectionStatus(state: state, index: index)
                }
            default:
                return
            }
        }
    }
    
    func updateNewlyConnectedPlayer() {
        let healthString = String(currentHealth)
        let experienceString = String(currentExperience)
        scenarioShareManager.broadcastStatUpdate(statType: Constants.healthStatType, value: healthString)
        scenarioShareManager.broadcastStatUpdate(statType: Constants.experienceStatType, value: experienceString)
    }
    
    func updatePlayersVisualConnectionStatus(state: MCSessionState, index: Int) {
        print("updating player at spot number \(index + 1), new state: \(state.rawValue) - (0 = connected, 2 = disconnected)")
        switch state {
        case .connected:
            switch index {
            case 0:
                self.playerNameLabels[index].backgroundColor = ColorConstants.connectedPlayerBackground
                self.playerNameLabels[index].textColor = ColorConstants.connectedPlayerText
            case 1:
                self.playerNameLabels[index].backgroundColor = ColorConstants.connectedPlayerBackground
                self.playerNameLabels[index].textColor = ColorConstants.connectedPlayerText
            case 2:
                self.playerNameLabels[index].backgroundColor = ColorConstants.connectedPlayerBackground
                self.playerNameLabels[index].textColor = ColorConstants.connectedPlayerText
            default:
                return
            }
        case .notConnected:
            switch index {
            case 0:
                self.playerNameLabels[index].backgroundColor = ColorConstants.disconnectedPlayerBackground
                self.playerNameLabels[index].textColor = ColorConstants.disconnectedPlayerText
            case 1:
                self.playerNameLabels[index].backgroundColor = ColorConstants.disconnectedPlayerBackground
                self.playerNameLabels[index].textColor = ColorConstants.disconnectedPlayerText
            case 2:
                self.playerNameLabels[index].backgroundColor = ColorConstants.disconnectedPlayerBackground
                self.playerNameLabels[index].textColor = ColorConstants.disconnectedPlayerText
            default:
                return
            }
        case .connecting:
            return
        }
    }
    
    func updateStackViews() {
        let playerCount = players.count
        switch playerCount {
        case 0:
            noOtherPlayersLabel.isHidden = false
            player2StatStack.isHidden = true
            player3StatStack.isHidden = true
            player4StatStack.isHidden = true
        case 1:
            noOtherPlayersLabel.isHidden = true
            player2StatStack.isHidden = false
            player3StatStack.isHidden = true
            player4StatStack.isHidden = true
        case 2:
            noOtherPlayersLabel.isHidden = true
            player2StatStack.isHidden = false
            player3StatStack.isHidden = false
            player4StatStack.isHidden = true
        case 3:
            noOtherPlayersLabel.isHidden = true
            player2StatStack.isHidden = false
            player3StatStack.isHidden = false
            player4StatStack.isHidden = false
        default:
            return
        }
    }
    
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
        let healthCounterView = Bundle.main.loadNibNamed(Constants.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView
        healthCounterView?.frame = healthTrackerContainerView.bounds
        
        // stubbed - need to get health and maxvalue from character
        let characterHealth = 17
        healthCounterView?.configure(value: characterHealth, counterType: .health, maxValue: characterHealth)
        currentHealth = characterHealth
        
        healthTrackerContainerView.addSubview(healthCounterView!)
        healthCounterView?.delegate = self
    }
    
    func setupExperienceCounterView() {
        let experienceCounterView = Bundle.main.loadNibNamed(Constants.horizontalCounterNibName, owner: self, options: nil)?.first as? CounterView
        experienceCounterView?.frame = experienceTrackerContainerView.bounds
        experienceCounterView?.configure(value: 0, counterType: CounterType.experience)
        experienceTrackerContainerView.addSubview(experienceCounterView!)
        experienceCounterView?.delegate = self
    }
    
    func setupGenericCounterView() {
        let genericCounterView = Bundle.main.loadNibNamed(Constants.verticalCounterNibName, owner: self, options: nil)?.first as?CounterView
        genericCounterView?.frame = genericTrackerContainerView.bounds
        genericCounterView?.configure(value: 0, counterType: CounterType.generic)
        genericTrackerContainerView.addSubview(genericCounterView!)
        genericCounterView?.delegate = self
    }
    
}
