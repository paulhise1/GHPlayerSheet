import UIKit

class ScenarioLobbyViewController: UIViewController {

    struct Constant {
        static let segueToScenarioID = "toScenarioVC"
        static let backgroundList = ["scenarioSetup", "scenarioSetup2", "scenarioSetup3", "scenarioSetup4"]
    }
    
    @IBOutlet weak var viewBackgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        let random = Int(arc4random_uniform(4))
        print(random)
        viewBackgroundImage.image = UIImage(named: Constant.backgroundList[random])
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    
    
    
}
