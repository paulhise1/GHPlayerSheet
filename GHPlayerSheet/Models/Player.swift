import Foundation

class Player: Codable, ModelProtocol {
    
    var ownedCharacters: [Character]?
    var activeCharacter: Character
    var identifier: Date
    
    init(activeCharacter: Character, owndedCharacters: [Character], identifier: Date = Date()) {
        self.activeCharacter = activeCharacter
        self.ownedCharacters = owndedCharacters
        self.identifier = identifier
    }
}
