import Foundation

//protocol CharacterSheetViewModelDelegate: class {
//    func updateCharacter()
//}

class CharacterSheetViewModel {
    
    struct Constants {
        static let pathComponent = "characters.plist"
    }
    
    var characterModel: Character
    private var characterDatasource: ModelDatasource<Character>?
    
    init(characterDatasource: ModelDatasource<Character>) {
        self.characterDatasource = characterDatasource
        
        characterModel = characterDatasource.modelAt(index: 0)
    }
    
    func updateName(name: String) {
        characterModel.updateName(name: name)
        characterDatasource?.update(model: characterModel)
    }
    
    func updateGold(amount: Int) {
        characterModel.updateGold(amount: amount)
        characterDatasource?.update(model: characterModel)
    }
    
    func updateExperience(amount: Int) {
        characterModel.updateExperience(amount: amount)
        characterDatasource?.update(model: characterModel)
    }
}
