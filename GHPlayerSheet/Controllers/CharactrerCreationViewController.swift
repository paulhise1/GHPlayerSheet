import UIKit

class CharacterCreationViewController: UIViewController {

    var newCharacter: CharacterModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func newCharacterButtonTapped(_ sender: Any) {
        //Stubbed
        newCharacter = CharacterModel(characterClass: .brute, gold: 47, experience: 133)
        performSegue(withIdentifier: "toCharacterSheet", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CharacterSheetViewController
        destinationVC.currentCharacter = newCharacter ?? nil
    }
}


