import Foundation

class Character: Codable, ModelProtocol {
    
    static func !=(lhs: Character, rhs: Character) -> Bool {
        return lhs.identifier != rhs.identifier
    }
    
    let classType: ClassType
    private(set) var name: String
    private let creationDate: Date
    
    var identifier: Date {
        return creationDate
    }
    
    var health: Int {
        return ClassTypeData.health(for: classType, level: level)
    }
    
    var level: Int {
        return ClassTypeData.level(for: self.experience)
    }
    
    var active: Bool
    private(set) var experience: Int
    private(set) var gold: Int
    private(set) var battlemarks = 0
    private(set) var activePerks = [String]()
    
    init(classType: ClassType, name: String, gold: Int, experience: Int = 0, active: Bool = true) {
        self.classType = classType
        self.name = name
        self.experience = experience
        self.gold = gold
        self.creationDate = Date()
        self.active = active
    }
    
    func updateName(name: String) {
        self.name = name
    }
    
    func updateGold(amount: Int) {
        gold = gold + amount
    }
    
    func updateExperience(amount: Int) {
        experience = experience + amount
    }
    
    func updateBattlemarks(amount: Int) {
        battlemarks += amount
    }
}
