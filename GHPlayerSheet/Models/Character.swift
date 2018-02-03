import Foundation

enum CharacterClass: String, Codable {
    case Cragheart = "Savvas Cragheart"
    case scoundrel = "Human Scoundrel"
    case tinkerer = "Quatryl Tinkerer"
    case mindthief = "Vermling Mindthief"
    case spellweaver = "Orchid Spellweaver"
    case brute = "Inox Brute"
}
    
class Character: Codable, ModelProtocol {

    let characterClass: CharacterClass
    private(set) var name: String
    private let creationDate: Date
    
    var identifier: Date {
        return creationDate
    }
    var health: String {
        return calculateHealth()
    }
    var level: String {
        return calculateLevel()
    }
    
    static let classes = [CharacterClass.Cragheart, CharacterClass.scoundrel, CharacterClass.tinkerer, CharacterClass.mindthief, CharacterClass.spellweaver, CharacterClass.brute]
    
    private(set) var experience: Int
    private(set) var gold: Int?
    private(set) var battleMarksCount: Int?
    private(set) var activePerks = [String]()
    //private(set) var items = [ItemType]()
    
    init(characterClass: CharacterClass, name: String, experience: Int = 0) {
        self.characterClass = characterClass
        self.name = name
        self.experience = experience
        self.creationDate = Date()
    }
    
    func updateName(name: String) {
        self.name = name
    }
    
    func updateGold(amount: Int) {
        guard var gold = gold else { return }
        gold = gold + amount
    }
    
    func updateExperience(amount: Int) {
        experience = experience + amount
    }
    
    private func calculateHealth() -> String {
        var healthValues: [Int]
        switch characterClass {
        case .Cragheart:
            healthValues = [10,12,14,16,18,20,22,24,26]
        case .scoundrel:
            healthValues = [8,9,11,12,14,15,17,18,20]
        case .tinkerer:
            healthValues = [8,9,11,12,14,15,17,18,20]
        case .mindthief:
            healthValues = [6,7,8,9,10,11,12,13,14]
        case .spellweaver:
            healthValues = [6,7,8,9,10,11,12,13,14]
        case .brute:
            healthValues = [10,12,14,16,18,20,22,24,26]
        }
        return String(healthValues[Int(level)!-1])
    }
    
    private func calculateLevel() -> String {
        switch experience {
        case 0...44:
            return "1"
        case 45...94:
            return "2"
        case 95...149:
            return "3"
        case 150...209:
            return "4"
        case 210...274:
            return "5"
        case 275...344:
            return "6"
        case 345...419:
            return "7"
        case 420...499:
            return "8"
        default:
            return "9"
        }
    }
}
