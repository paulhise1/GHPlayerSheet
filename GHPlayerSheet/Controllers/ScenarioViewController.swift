import UIKit

class ScenarioViewController: UIViewController, CounterViewDelegate, ScenarioShareManagerDelegate {
    
    let scenarioShare = ScenarioShareManager()
    
    @IBOutlet weak var connectedDevicesLabel: UILabel!
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2HealthLabel: UILabel!
    @IBOutlet weak var player2ExperienceLabel: UILabel!
    
    @IBOutlet weak var player3NameLabel: UILabel!
    @IBOutlet weak var player3HealthLabel: UILabel!
    @IBOutlet weak var player3ExperienceLabel: UILabel!
    
    @IBOutlet weak var player4NameLabel: UILabel!
    @IBOutlet weak var player4HealthLabel: UILabel!
    @IBOutlet weak var player4ExperienceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scenarioShare.delegate = self
        setupCounters()
    }
  
    func counterValueDidChange(value: Int, type: CounterType) {
        print("value: \(value), type: \(type)")
    }
    
    func setPlayerNames() {
//        player2NameLabel.text =
//        player3NameLabel.text =
//        player4NameLabel.text =
    }
    
    func updateAllStats() {
        broadcastMyStats()
        changePlayer2Stats()
        changePlayer3Stats()
        changePlayer4Stats()
    }
    
    func broadcastMyStats() {
        
    }
    
    func changePlayer2Stats() {
//        player2HealthLabel.text =
//        player2ExperienceLabel.text =
    }
    
    func changePlayer3Stats() {
//        player3HealthLabel.text =
//        player3ExperienceLabel.text =
    }
    
    func changePlayer4Stats() {
//        player4HealthLabel.text =
//        player4ExperienceLabel.text =
    }
    
    //MARK:- MCScenarioShare delegates to register stat changes.
    func connectedDevicesChanged(manager: ScenarioShareManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            // want to use the connectedDevices list to divy out which of the other players will fill in which slots in the stack view
            
            self.connectedDevicesLabel.text = self.updateWhoIsConnectedLabel(connectedDevices: connectedDevices)
            self.updateAllStats()
        }
    }
    
    func statChanged(manager: ScenarioShareManager, statString: String) {
        // need some way, possibly a switch to figure out who sent data change and put it in the column accordingly
        //example from tutorial, seems like changes need to be on main thread
//        OperationQueue.main.addOperation {
//            switch colorString {
//            case "red":
//                self.change(color: .red)
//            case "yellow":
//                self.change(color: .yellow)
//            default:
//                NSLog("%@", "Unknown color value received: \(colorString)")
//            }
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
        healthCounterView?.setupCounter(startingValue: 15, type: .health, maxValue: 15)
        healthTrackerContainerView.addSubview(healthCounterView!)
        healthCounterView?.delegate = self
    }
    
    func setupExperienceCounterView() {
        let experienceCounterView = Bundle.main.loadNibNamed("HorizontalCounterView", owner: self, options: nil)?.first as? CounterView
        experienceCounterView?.frame = experienceTrackerContainerView.bounds
        experienceCounterView?.setupCounter(startingValue: 0, type: CounterType.experience)
        experienceTrackerContainerView.addSubview(experienceCounterView!)
        experienceCounterView?.delegate = self
    }
    
    func setupGenericCounterView() {
        let genericCounterView = Bundle.main.loadNibNamed("VerticalCounterView", owner: self, options: nil)?.first as?CounterView
        genericCounterView?.frame = genericTrackerContainerView.bounds
        genericCounterView?.setupCounter(startingValue: 0, type: CounterType.generic)
        genericTrackerContainerView.addSubview(genericCounterView!)
        genericCounterView?.delegate = self
    }
    
}




