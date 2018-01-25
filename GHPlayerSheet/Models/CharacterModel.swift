import Foundation


class CharacterModel: Codable, ModelProtocol {
    
    let characterClass : CharacterClass
    var creationDate: Date
    var name = ""
    var level = 1
    var experience = 0
    var gold = 0
    //var items = [ItemType]()
    var battleMarks = 0
    var activePerks = [String]()
    
    init(characterClass: CharacterClass, creationDate: Date = Date(), gold: Int = 0, experience: Int = 0) {
        self.characterClass = characterClass
        self.creationDate = creationDate
        self.gold = gold
        self.experience = experience
    }

    func identifier() -> Date {
        return creationDate
    }
}

extension CharacterModel {
    
    enum CharacterClass: String, Codable {
        case cragheart = "Savvas Cragheart"
        case scoundrel = "Human Scoundrel"
        case tinkerer = "Quatryl Tinkerer"
        case mindthief = "Vermling Mindthief"
        case spellweaver = "Orchid Spellweaver"
        case brute = "Inox Brute"
    }
    
//    enum ItemType: String, Codable {
//        case
//    }
    
    

}
