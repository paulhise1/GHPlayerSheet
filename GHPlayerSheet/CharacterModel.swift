import Foundation

enum ClassType: String {
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
    
    let classType : ClassType
    var name : String
    var level : Int
    var xp = 0
    var gold = 0
    var items = [ItemType]()
    var battleMarks = 0
    var activePerks = [String]()
    var notes = ""
    
    init(classType: ClassType, name: String, level: Int) {
        self.classType = classType
        self.name = name
        self.level = level
    }
    




}
