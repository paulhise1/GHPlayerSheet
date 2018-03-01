import Foundation

protocol CharacterSheetViewModelDelegate: class {
    func didUpdateCharacter(character: Character)
}

class CharacterSheetViewModel {
    
    weak var delegate: CharacterSheetViewModelDelegate?
    
    struct Constants {
        static let pathComponent = "characters.plist"
    }
    
    var character: Character
    
    init(character: Character) {
        self.character = character
        delegate?.didUpdateCharacter(character: character)
    }
    
    func updateName(name: String) {
        character.updateName(name: name)
        delegate?.didUpdateCharacter(character: character)
    }
    
    func updateGold(amount: Int) {
        character.updateGold(amount: amount)
        delegate?.didUpdateCharacter(character: character)
    }
    
    func updateExperience(amount: Int) {
        character.updateExperience(amount: amount)
        delegate?.didUpdateCharacter(character: character)
    }
}
