import Foundation

class CharacterSheetViewModel {
    
    struct Constants {
        static let pathComponent = "characters.plist"
    }
    
    // Stubbed until hub view controller will hold onto character datasource
    // this Viewmodel will delegate back to hub to make saves to character
    // it will get injected with the characterModel from the hub
    private let characterDatasource: ModelDatasource<CharacterModel>
    
    var characterModel: CharacterModel
    
    init() {
        let url = URL.libraryFilePathWith(finalPathComponent: Constants.pathComponent)
        characterDatasource = ModelDatasource(with: url)
        
        characterModel = characterDatasource.modelAt(index: 0)
    }
    
    func updateName(name: String) {
        characterModel.updateName(name: name)
        characterDatasource.update(model: characterModel)
    }
    
    func updateGold(amount: Int) {
        characterModel.updateGold(amount: characterModel.gold + amount)
        characterDatasource.update(model: characterModel)
    }
    
    func updateExperience(amount: Int) {
        characterModel.updateExperience(amount: characterModel.experience + amount)
        characterDatasource.update(model: characterModel)
    }
}
