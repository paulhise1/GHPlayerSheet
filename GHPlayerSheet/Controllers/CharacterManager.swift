import Foundation

class CharacterManager: ModelProtocol {
    
    struct Constants {
        static let pathComponent = "characters.plist"
    }
    
    let charactersDatasource: ModelDatasource<CharacterModel>
    var character: CharacterModel?
    
    init() {
        let url = URL.libraryFilePathWith(finalPathComponent: Constants.pathComponent)
        self.charactersDatasource = ModelDatasource(with: url)
        
        //stubbed
        character = charactersDatasource.modelAt(index: 0)
    }
    
    // will be called when selecting a character from a character selection screen
    func getCharacter(characterAt index: Int) -> CharacterModel? {
        character = charactersDatasource.modelAt(index: index)
        if let character = character {
            return character
        } else {
            return nil
        }
    }
    
    func getCharacterType() -> CharacterModel.CharacterClass? {
        if let character = character {
            return character.characterClass
        } else { return nil }
    }
    
    func identifier() -> Date {
        if let character = character {
            return character.creationDate
        } else {
            return Date()
        }
    }
    
    func updateGold(amount: Int) -> Int {
        if let character = character {
            character.gold = character.gold + amount
            charactersDatasource.update(model: character)
            return character.gold
        } else {
            return 0
        }
    }
    
    
    func updateExperience(amount: Int) -> Int {
        if let character = character {
            character.experience = character.experience + amount
            charactersDatasource.update(model: character)
            return character.experience
        } else {
            return 0
        }
    }
    
    func setName(name: String) {
        if let character = character {
            character.name = name
            charactersDatasource.update(model: character)
        }
    }
    

}
