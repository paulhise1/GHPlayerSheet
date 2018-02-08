import Foundation

class CharacterClass: Codable, ModelProtocol {
    
    enum charClass: String, Codable {
        case cragheart = "Savvas Cragheart"
        case scoundrel = "Human Scoundrel"
        case tinkerer = "Quatryl Tinkerer"
        case mindthief = "Vermling Mindthief"
        case spellweaver = "Orchid Spellweaver"
        case brute = "Inox Brute"
        case quartermaster = "Valrath QuarterMaster"
    }
    
    static let startingClasses = [CharacterClass.charClass.cragheart,  CharacterClass.charClass.tinkerer,  CharacterClass.charClass.mindthief]
    static let unlockableClasses = [CharacterClass.charClass.scoundrel, CharacterClass.charClass.spellweaver, CharacterClass.charClass.brute, CharacterClass.charClass.quartermaster]

    let classOf: CharacterClass.charClass
    var unlocked: Bool
    var owned: Bool
    var identifier: Date
    
    init(classOf: CharacterClass.charClass, unlocked: Bool, owned: Bool, identifier: Date = Date()) {
        self.classOf =  classOf
        self.unlocked = unlocked
        self.owned = owned
        self.identifier = identifier
    }
    
    static func characterLockedImageForClass(charClass: CharacterClass.charClass) -> String {
        switch charClass {
        case .cragheart:
            return "cragheartSymbol"
        case .brute:
            return "bruteSymbol"
        case .mindthief:
            return "mindthiefSymbol"
        case .scoundrel:
            return "scoundrelSymbol"
        case .spellweaver:
            return "spellweaverSymbol"
        case .tinkerer:
            return "tinkererSymbol"
        case .quartermaster:
            return "quartermasterSymbol"
        }
    }
    
    static func characterUnlockedImageForClass(charClass: CharacterClass.charClass) -> String {
        switch charClass {
        case .cragheart:
            return "cragheartCard"
        case .brute:
            return "bruteCard"
        case .mindthief:
            return "mindthiefCard"
        case .scoundrel:
            return "scoundrelCard"
        case .spellweaver:
            return "spellweaverCard"
        case .tinkerer:
            return "tinkererCard"
        case .quartermaster:
            return "quartermasterCard"
        }
    }
    
    static func characterOwnedImageForClass(charClass: CharacterClass.charClass) -> String {
        switch charClass {
        case .cragheart:
            return "cragheart"
        case .brute:
            return "brute"
        case .mindthief:
            return "mindthief"
        case .scoundrel:
            return "scoundrel"
        case .spellweaver:
            return "spellweaver"
        case .tinkerer:
            return "tinkerer"
        case .quartermaster:
            return "quartermaster"
        }
    }
    
}
