import Foundation

enum CharacterClass: String, Codable {
    case cragheart = "Savvas Cragheart"
    case scoundrel = "Human Scoundrel"
    case tinkerer = "Quatryl Tinkerer"
    case mindthief = "Vermling Mindthief"
    case spellweaver = "Orchid Spellweaver"
    case brute = "Inox Brute"
}
    
class CharacterModel: Codable, ModelProtocol {
    
    let characterClass : CharacterClass
    let creationDate: Date
    var health: String {
        return String((level * 2) + 8)
    }
    private(set) var name = ""
    private(set) var level = 1
    private(set) var experience = 0
    private(set) var gold = 0
    private(set) var battleMarks = 0
    private(set) var activePerks = [String]()
    //private(set) var items = [ItemType]()
    
    init(characterClass: CharacterClass, creationDate: Date = Date(), gold: Int = 0, experience: Int = 0) {
        self.characterClass = characterClass
        self.creationDate = creationDate
        self.gold = gold
        self.experience = experience
    }

    func identifier() -> Date {
        return creationDate
    }
    
    func updateName(name: String) {
        self.name = name
    }
    
    func updateGold(amount: Int) {
        gold = amount
    }
    
    func updateExperience(amount: Int) {
        experience = experience + amount
    }
    
}

    
//    enum ItemType: String, Codable {
//        case
//    }
    

