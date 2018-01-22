import Foundation

enum CharacterClass: String {
    case none
    case cragheart = "Savvas Cragheart"
    case scoundrel = "Human Scoundrel"
    case tinkerer = "Quatryl Tinkerer"
    case mindthief = "Vermling Mindthief"
    case spellweaver = "Orchid Spellweaver"
    case brute = "Inox Brute"
}

enum ItemType {

}

class CharacterModel {
    
    let characterClass : CharacterClass
    var name : String
    var level : Int
    var experience = 0
    var gold = 0
    var items = [ItemType]()
    var battleMarks = 0
    var activePerks = [String]()
    var notes: NotesDatasource?
    
    init(characterClass: CharacterClass, name: String, level: Int) {
        self.characterClass = characterClass
        self.name = name
        self.level = level
    }

    func updateGold(amount: Int) -> Int {
        gold = gold + amount
        return gold
    }
    
    func updateExperience(amount: Int) -> Int {
        experience = experience + amount
        return experience
    }
    
    
}
