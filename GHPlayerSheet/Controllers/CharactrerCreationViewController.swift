import UIKit

class CharacterCreationViewController: UIViewController {

    let characterDatasource = CharactersDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createCharacterTapped(_ sender: Any) {
        
        //Stubbed
        let newCharacter = CharacterModel(characterClass: .brute)
        newCharacter.gold = 47
        newCharacter.experience = 133
        characterDatasource.updateCharacter(updatedCharacter: newCharacter)
        performSegue(withIdentifier: "toCharacterSheet", sender: self)
        
    }
    

}
