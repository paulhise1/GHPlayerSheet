import UIKit
import MultipeerConnectivity

enum StatUpdateType {
    case name
    case health
    case experience
}

class ScenarioViewController: UIViewController, CounterViewDelegate, ScenarioShareManagerDelegate {
    
    let scenarioShareManager = ScenarioShareManager()
    
   
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
            statType = "health"
        case .experience:
            statType = "experience"
        default:
            return
        }
        scenarioShareManager.broadcastStatDidChange(statType: statType!, value: stringValue)
    }
    
    func statChanged(statType: StatUpdateType, value: String, displayName: String) {
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
    func deviceConnectionStateChanged(displayName: String, state: MCSessionState) {
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
                if let index = self.players.index(of: displayName) {
                    self.updatePlayersVisualConnectionStatus(state: state, index: index)
                }
            case .notConnected:
                //TODO: handle disconnects
                if self.players.contains(displayName) {
                    if let index = self.players.index(of: displayName) {
                        self.updatePlayersVisualConnectionStatus(state: state, index: index)
                    }
                }
                return
            default:
                return
            }
            
            //self.connectedDevicesLabel.text = self.updateWhoIsConnectedLabel(connectedDevices: self.players)
        }
    }
    
    func updatePlayersVisualConnectionStatus(state: MCSessionState, index: Int) {
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
    
    func updateWhoIsConnectedLabel(connectedDevices: [String]) -> String {
        var connectedDevicesString = "Connected friends:"
        for devices in connectedDevices {
            connectedDevicesString = connectedDevicesString + ", " + devices
        }
        if let i = connectedDevicesString.index(of: ",") {
            connectedDevicesString.remove(at: i)
        }
        return connectedDevicesString
    }
    
    
    //MARK: - Setup Child Views
    func setupCounters() {
        setupHealthCounterView()
        setupExperienceCounterView()
        setupGenericCounterView()
    }
    
    func setupHealthCounterView() {
        let healthCounterView = Bundle.main.loadNibNamed("HorizontalCounterView", owner: self, options: nil)?.first as? CounterView
        healthCounterView?.frame = healthTrackerContainerView.bounds
        healthCounterView?.configure(value: 15, counterType: .health, maxValue: 15)
        healthTrackerContainerView.addSubview(healthCounterView!)
        healthCounterView?.delegate = self
    }
    
    func setupExperienceCounterView() {
        let experienceCounterView = Bundle.main.loadNibNamed("HorizontalCounterView", owner: self, options: nil)?.first as? CounterView
        experienceCounterView?.frame = experienceTrackerContainerView.bounds
        experienceCounterView?.configure(value: 0, counterType: CounterType.experience)
        experienceTrackerContainerView.addSubview(experienceCounterView!)
        experienceCounterView?.delegate = self
    }
    
    func setupGenericCounterView() {
        let genericCounterView = Bundle.main.loadNibNamed("VerticalCounterView", owner: self, options: nil)?.first as?CounterView
        genericCounterView?.frame = genericTrackerContainerView.bounds
        genericCounterView?.configure(value: 0, counterType: CounterType.generic)
        genericTrackerContainerView.addSubview(genericCounterView!)
        genericCounterView?.delegate = self
    }
    
}
