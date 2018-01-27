import Foundation

class CharacterSheetViewModel: ModelProtocol {
    
    struct Constants {
        static let pathComponent = "characters.plist"
    }
    
    // Stubbed until hub view controller will hold onto character datasource
    // this Viewmodel will delegate back to hub to make saves to character
    // it will get injected with the characterModel from the hub
    private let characterDatasource: ModelDatasource<CharacterModel>
    
    private var characterModel: CharacterModel
    
    init() {
        let url = URL.libraryFilePathWith(finalPathComponent: Constants.pathComponent)
        characterDatasource = ModelDatasource(with: url)
        
        characterModel = characterDatasource.modelAt(index: 0)
    }
    
    func character() -> CharacterModel {
        return characterModel
    }
    
    func characterClass() -> CharacterClass {
        let characterClass = characterModel.characterClass
        return characterClass
    }
    
    func identifier() -> Date {
        return characterModel.creationDate
    }
    
    func name() -> String {
        return characterModel.name
    }
    
    func gold() -> Int {
        return characterModel.gold
    }
    
    func experience() -> Int {
        return characterModel.experience
    }
    
    func setName(name: String) {
        characterModel.name = name
        characterDatasource.update(model: characterModel)
    }
    
    func updateGold(amount: Int) -> Int {
        characterModel.gold = characterModel.gold + amount
        characterDatasource.update(model: characterModel)
        return characterModel.gold
    }
    
    
    func updateExperience(amount: Int) -> Int {
        characterModel.experience = characterModel.experience + amount
        characterDatasource.update(model: characterModel)
        return characterModel.experience
    }
    

}
