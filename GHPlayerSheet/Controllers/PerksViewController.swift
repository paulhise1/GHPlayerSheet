import UIKit

class PerksViewController: UIViewController {

    var perkType: PerkListType?
    var perkID: Date?
    var perkManager: PerkManager?
    var characterManager: CharacterManager?
    var earnedPerks: [PerkModel]?
    var perkList: [PerkModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perkManager = PerkManager()
        characterManager = CharacterManager()
        perkType = .brute
        //getPerkList()
    }
        // need to figure out how to get character type from character manager
//    func getPerkList() {
//        let characterClass = characterManager?.getCharacterType()
//        switch characterClass {
//        case "brute":
//            perkType = PerkListType.brute
//        case "cragheart":
//            perkType = PerkListType.cragheart
//        case "mindthief":
//            perkType = PerkListType.mindthief
//        case "spellweaver":
//            perkType = PerkListType.spellweaver
//        case "scoundrel":
//            perkType = PerkListType.scoundrel
//        case "tinkerer":
//            perkType = PerkListType.tinkerer
//        }
//    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PerkToAddViewController
        if let perkType = perkType {
            destinationVC.perkListType = perkType
        }
        //destinationVC.delegate = self
    }
    
}




