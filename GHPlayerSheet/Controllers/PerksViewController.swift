import UIKit



class PerksViewController: UIViewController {

    private var earnedPerks: [PerkModel]?
    private var perks: [PerkModel]?
    private var perkViewModel: PerkViewModel?
    private var characterClass: CharacterClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perkViewModel = PerkViewModel()
        if let characterClass = characterClass {
            buildPerkList(characterClass: characterClass)
        }
    }
    
    func configure(with characterClass: CharacterClass) {
        self.characterClass = characterClass
    }
  
    func buildPerkList(characterClass: CharacterClass) {
        if let perkViewModel = perkViewModel {
            perks = perkViewModel.perksList(perksFor: characterClass)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PerkToAddViewController
        if let perks = perks {
            destinationVC.configure(with: perks)
        }
        //destinationVC.delegate = self
    }
    
}




