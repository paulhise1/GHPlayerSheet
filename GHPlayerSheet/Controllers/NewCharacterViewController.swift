import UIKit

class NewCharacterViewController: UIViewController {

    struct Constants {
        static let pathComponent = "characters.plist"
    }
    
    var characterDatasource: ModelDatasource<CharacterModel>?
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constants.pathComponent)
        self.characterDatasource = ModelDatasource(with: url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        character = CharacterModel(characterClass: .brute, gold: 30, experience: 45)
        if let character = character {
            characterDatasource?.update(model: character)
        }
    }
    
}
