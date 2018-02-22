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
    
    private(set) var experience: Int
    private(set) var gold: Int?
    private(set) var battleMarksCount: Int?
    private(set) var activePerks = [String]()
    
    init(classType: ClassType, name: String, experience: Int = 0) {
        self.classType = classType
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
}
