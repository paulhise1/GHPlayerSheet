import UIKit

class ScenarioViewController: UIViewController, CounterViewDelegate, ScenarioShareManagerDelegate {
    
    let scenarioShare = ScenarioShareManager()
    
    @IBOutlet weak var connectedDevicesLabel: UILabel!
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scenarioShare.delegate = self
        setupCounters()
    }
  
    func counterValueDidChange(value: Int, sender: CounterView) {
        
    }
    
    func setupCounters() {
        setupHealthCounterView()
        setupExperienceCounterView()
        setupGenericCounterView()
    }
    
    //MARK:- MCScenarioShare delegates to register stat changes.
    func connectedDevicesChanged(manager: ScenarioShareManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            var connectedDevicesString = "Connected friends:"
            for devices in connectedDevices {
                 connectedDevicesString = connectedDevicesString + ", " + devices
            }
            if let i = connectedDevicesString.index(of: ",") {
                connectedDevicesString.remove(at: i)
            }
            self.connectedDevicesLabel.text = connectedDevicesString
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
    
    
    //MARK: - Setup Child Views
    func setupHealthCounterView() {
        let healthCounterView = Bundle.main.loadNibNamed("HorizontalCounterView", owner: self, options: nil)?.first as? CounterView
        healthCounterView?.frame = healthTrackerContainerView.bounds
        healthCounterView?.setupCounter(startingValue: 15, type: CounterType.health, maxValue: 15)
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




