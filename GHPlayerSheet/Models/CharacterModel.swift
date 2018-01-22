import Foundation


class CharacterModel: Codable {
    
    let characterClass : CharacterClass
    var name = ""
    var level = 1
    var experience = 0
    var gold = 0
    //var items = [ItemType]()
    var battleMarks = 0
    var activePerks = [String]()
    //var notes: NotesDatasource?
    
    init(characterClass: CharacterClass) {
        self.characterClass = characterClass
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
