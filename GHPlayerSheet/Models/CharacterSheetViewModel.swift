import Foundation

//protocol CharacterSheetViewModelDelegate: class {
//    func updateCharacter()
//}

class CharacterSheetViewModel {
    
    struct Constants {
        static let pathComponent = "characters.plist"
    }
    
    var character: Character
    private var characterDatasource: ModelDatasource<Character>?
    
    init(characterDatasource: ModelDatasource<Character>) {
        self.characterDatasource = characterDatasource
        
        character = characterDatasource.modelAt(index: 0)
    }
    
    func updateName(name: String) {
        character.updateName(name: name)
        characterDatasource?.update(model: character)
    }
    
    func updateGold(amount: Int) {
        character.updateGold(amount: amount)
        characterDatasource?.update(model: character)
    }
    
    func updateExperience(amount: Int) {
        character.updateExperience(amount: amount)
        characterDatasource?.update(model: character)
    }
}
