import Foundation

class Character: Codable, ModelProtocol {

    class Constant {
        static let lowHealth = [6,7,8,9,10,11,12,13,14]
        static let medHealth = [8,9,11,12,14,15,17,18,20]
        static let highHealth = [10,12,14,16,18,20,22,24,26]
    }
    
    let characterClass: CharacterClass.charClass
    private(set) var name: String
    private let creationDate: Date
    
    var identifier: Date {
        return creationDate
    }
    var health: String {
        return calculateHealth()
    }
    var level: String {
        return Character.calculateLevel(experience: self.experience)
    }
    
    
    
    private(set) var experience: Int
    private(set) var gold: Int?
    private(set) var battleMarksCount: Int?
    private(set) var activePerks = [String]()
    //private(set) var items = [ItemType]()
    
    init(characterClass: CharacterClass.charClass, name: String, experience: Int = 0) {
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
    
    static func levelForExperience(experience: Int) -> String {
        return calculateLevel(experience: experience)
    }
    
    private func calculateHealth() -> String {
        var healthValues: [Int]
        switch characterClass {
        case .cragheart:
            healthValues = Constant.highHealth
        case .scoundrel:
            healthValues = Constant.medHealth
        case .tinkerer:
            healthValues = Constant.medHealth
        case .mindthief:
            healthValues = Constant.lowHealth
        case .spellweaver:
            healthValues = Constant.lowHealth
        case .brute:
            healthValues = Constant.highHealth
        case .quartermaster:
            healthValues = Constant.highHealth
        case .sunkeeper:
            healthValues = Constant.highHealth
        case .soothsinger:
            healthValues = Constant.lowHealth
        case .sawbones:
            healthValues = Constant.medHealth
        case .berserker:
            healthValues = Constant.highHealth
        case .nightshroud:
            healthValues = Constant.medHealth
        case .doomstalker:
            healthValues = Constant.medHealth
        case .beasttyrant:
            healthValues = Constant.lowHealth
        case .summoner:
            healthValues = Constant.medHealth
        case .plagueherald:
            healthValues = Constant.lowHealth
        case .elementalist:
            healthValues = Constant.lowHealth
        }
        return String(healthValues[Int(level)!-1])
    }
    
    private static func calculateLevel(experience: Int) -> String {
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
