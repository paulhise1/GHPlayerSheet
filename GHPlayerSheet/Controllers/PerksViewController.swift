import UIKit

protocol PerksViewControllerDelegate: class {
    func perkSymbolListRequested()
}

class PerksViewController: UIViewController, PerkToAddTableViewCellDelegate {
   
    weak var delegate: PerksViewControllerDelegate?
    
    private var earnedPerks: [Perk]?
    private var perks: [Perk]?
    private var perkViewModel: PerkViewModel?
    private var characterClass: CharacterClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perkViewModel = PerkViewModel()
        if let characterClass = characterClass {
            buildPerkList(characterClass: characterClass)
        }
    }
    
    func perkSelectedForActive(perkAt: Int) {
        // need to take the perkmodel that was selected, add it to the active list and decrement the available count
    }
    
    func configure(with characterClass: CharacterClass) {
        self.characterClass = characterClass
    }
  
    func buildPerkList(characterClass: CharacterClass) {
            perks = Perk.perksList(perksFor: characterClass)
    }
    
    func symbolListShouldShow(sender: PerkToAddViewController) {
        delegate?.perkSymbolListRequested()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PerkToAddViewController
        if let perks = perks {
            destinationVC.configure(with: perks)
            destinationVC.delegate = self
        }
        
    }
    
}




