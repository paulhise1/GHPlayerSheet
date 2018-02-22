import Foundation

struct ScenarioPlayer: Hashable, Equatable {
    
    var hashValue: Int {
        return name.hashValue
    }
    
    var name: String
    var experience = "0"
    var health: String
    var maxHealth: String
    var loot: String = "0"
    var battlemarks: String = "0"
    
    init(from character: Character) {
        self.name = character.name
        self.health = String(character.health)
        self.maxHealth = String(character.health)
    }
    
    init(name: String, experience: String, health: String, maxHealth: String, loot: String) {
        self.name = name
        self.experience = experience
        self.health = health
        self.maxHealth = maxHealth
        self.loot = loot
    }
    
    static func ==(lhs: ScenarioPlayer, rhs: ScenarioPlayer) -> Bool {
        return lhs.name == rhs.name
    }
}
