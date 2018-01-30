import UIKit
import Firebase

class HubViewController: UIViewController {

    struct Constants {
        static let pathComponent = "characters.plist"
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioID = "toScenarioViewController"
    }
    
    
    @IBOutlet weak var numpadContainerView: UIView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var joinScenarioLabel: UILabel!
    @IBOutlet weak var joinScenarioButton: UIButton!
    
    var characterDatasource: ModelDatasource<CharacterModel>?
    var character: CharacterModel?
    
    var database: DatabaseReference!
    
    //stubbed properties
    let partyName = "Harlem Globe Trotters"
    let playerName = "Mr Bob Dobalina"
    let playerName2 = "Lu Bu"
    //let partyName = "The Funk Hunters"
    let player = "player"
    let scenarioKey = "scenario"
    var scenarioNumber = 0
    //let playerName = "Djeniac"
    let playerHealth = 12
    let playerMaxHealth = 12
    //let playerName2 = "Orsaf"
    let playerHealth2 = 15
    let playerMaxHealth2 = 15
    let playerExperience = 0
    var playerInfo: [String : Any]?
    var playerInfo2: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Database.database().reference()
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constants.pathComponent)
        self.characterDatasource = ModelDatasource(with: url)
        numpadContainerView.isHidden = true
        configureFirebaseListener()
        
        //stubbed
        playerInfo = ["health": playerHealth, "experience": playerExperience, "maxHealth": playerMaxHealth] as [String : Any]
        playerInfo2 = ["health": playerMaxHealth2, "experience": playerExperience, "maxHealth": playerMaxHealth2] as [String : Any]
    }
    
    func configureFirebaseListener(){
        let scenarioRef = database.child(partyName).child(scenarioKey)
        scenarioRef.observe(.value, with: { (snapshot) in
            let scenarioDictFromFirebase = snapshot.value as? [String: Int]
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
            if let amount = amount, let playerInfo = playerInfo  {
                if amount > 0 && amount <= 95 {
                    scenarioNumber = amount
                    database.child(partyName).child(player).setValue(playerName)
                    database.child(partyName).child(scenarioKey).setValue(["scenarioNumber" : scenarioNumber])
                    database.child(partyName).child(player).child(playerName).setValue(playerInfo)
                    performSegue(withIdentifier: Constants.segueToScenarioID, sender: self)
                }
            }
        }
    }
    
    @IBAction func joinScenarioButtonTapped(_ sender: Any) {
        database.child(partyName).child(player).child(playerName2).setValue(playerInfo2)
        performSegue(withIdentifier: Constants.segueToScenarioID, sender: self)
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
        if segue.identifier == Constants.segueToCharacterSheetID {
            character = CharacterModel(characterClass: .brute, gold: 30, experience: 45)
            if let character = character {
                characterDatasource?.update(model: character)
            }
        }
    }
    
}
