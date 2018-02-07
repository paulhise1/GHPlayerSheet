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
    
    static let classes = [CharacterClass.charClass.cragheart, CharacterClass.charClass.scoundrel, CharacterClass.charClass.tinkerer, CharacterClass.charClass.mindthief, CharacterClass.charClass.spellweaver, CharacterClass.charClass.brute, CharacterClass.charClass.quartermaster]

    let classOf: CharacterClass.charClass
    private(set) var unlocked: Bool
    private(set) var owned: Bool
    var identifier: Date
    
    init(classOf: CharacterClass.charClass, unlocked: Bool, owned: Bool) {
        self.classOf =  classOf
        self.unlocked = unlocked
        self.owned = owned
        self.identifier = Date()
    }
    
    static func characterSymbolImageForClass(charClass: CharacterClass.charClass) -> String {
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
    
    static func characterImageForClass(charClass: CharacterClass.charClass) -> String {
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
