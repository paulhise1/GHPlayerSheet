import UIKit
import FirebaseDatabase

class HubViewController: UIViewController {

    struct Constant {
        static let pathComponent = "characters.plist"
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioID = "toScenarioViewController"
        static let playerKey = "players"
        static let scenarioKey = "scenario"
    }
    
    @IBOutlet weak var numpadContainerView: UIView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var joinScenarioLabel: UILabel!
    @IBOutlet weak var joinScenarioButton: UIButton!
    
    private var characterDatasource: ModelDatasource<CharacterModel>?
    private var character: CharacterModel?
    
    private var database: DatabaseReference!
    
    //stubbed properties
    //let partyName = "Harlem Globe Trotters"
    let partyName = "The Funk Hunters"
    
    var scenarioNumber = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.characterDatasource = ModelDatasource(with: url)
        
        database = Database.database().reference()
        numpadContainerView.isHidden = true
        configureFirebaseListener()
        
    }
    
    func configureFirebaseListener(){
        let scenarioRef = database.child(partyName).child(Constant.scenarioKey)
        scenarioRef.observe(.value, with: { (snapshot) in
            let scenarioDictFromFirebase = snapshot.value as? [String: String]
            if let scenarioDictFromFirebase = scenarioDictFromFirebase {
                let scenarioNumberFromFirebase = scenarioDictFromFirebase["scenarioNumber"]
                if let scenarioNumberFromFirebase = scenarioNumberFromFirebase {
                    self.joinScenarioLabel.text = "Your party's scenario is # \(scenarioNumberFromFirebase)"
                }
            }
        })
    }
   
    @IBAction func createScenarioButtonTapped(_ sender: Any) {
        numpadContainerView.isHidden = false
    }
    
    @IBAction func startScenarioButtonTapped(_ sender: Any) {
        if let amountString = amountLabel.text {
            let amount = Int(amountString)
            if let amount = amount {
                if amount > 0 && amount <= 95 {
                    scenarioNumber = amountString
                    database.child(partyName).setValue(Constant.playerKey)
                    database.child(partyName).child(Constant.scenarioKey).setValue(["scenarioNumber" : scenarioNumber])
                    performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
                }
            }
        }
    }
    
    @IBAction func joinScenarioButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
    }
    
    //MARK: - Number Pad Methods
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        var amount = amountLabel.text!
        if amount == "0" {
            amount = ""
        }
        if amount.count < 2 {
            amount = amount + sender.titleLabel!.text!
            amountLabel.text = amount
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        var amount = amountLabel.text!
        amount = String(amount.dropLast())
        if amount == "" {
            amount = "0"
        }
        amountLabel.text = amount
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueToCharacterSheetID {
            //Stubbed character created
            character = CharacterModel(characterClass: .brute, gold: 30, experience: 45)
            if let character = character {
                characterDatasource?.update(model: character)
            }
        }
    }
    
    
}
