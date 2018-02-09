import Foundation

class CharacterClass: Codable, ModelProtocol {
    
    enum charClass: String, Codable {
        case cragheart = "Savvas Cragheart"
        case scoundrel = "Human Scoundrel"
        case tinkerer = "Quatryl Tinkerer"
        case mindthief = "Vermling Mindthief"
        case spellweaver = "Orchid Spellweaver"
        case brute = "Inox Brute"
        case quartermaster = "Valrath Quartermaster"
        case sunkeeper = "Valrath Sunkeeper"
        case soothsinger = "Quatryl Soothsinger"
        case sawbones = "Human Sawbones"
        case berserker = "Inox Berserker"
        case nightshroud = "Aesther Nightshroud"
        case doomstalker = "Orchid Doomstalker"
        case beasttyrant = "Vermling Beast Tyrant"
        case summoner = "Aester Summoner"
        case plagueherald = "Harrower Plagueherald"
        case elementalist = "Savvas Elementalist"
    }
    
    static let startingClasses = [CharacterClass.charClass.cragheart,  CharacterClass.charClass.tinkerer,  CharacterClass.charClass.mindthief, CharacterClass.charClass.scoundrel, CharacterClass.charClass.spellweaver, CharacterClass.charClass.brute]
    static let unlockableClasses = [CharacterClass.charClass.quartermaster, CharacterClass.charClass.sunkeeper, CharacterClass.charClass.soothsinger, CharacterClass.charClass.sawbones, CharacterClass.charClass.berserker, CharacterClass.charClass.nightshroud, CharacterClass.charClass.doomstalker, CharacterClass.charClass.beasttyrant, CharacterClass.charClass.summoner, CharacterClass.charClass.plagueherald, CharacterClass.charClass.elementalist]

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
            return "cragheartSymbolCard"
        case .brute:
            return "bruteSymbolCard"
        case .mindthief:
            return "mindthiefSymbolCard"
        case .scoundrel:
            return "scoundrelSymbolCard"
        case .spellweaver:
            return "spellweaverSymbolCard"
        case .tinkerer:
            return "tinkererSymbolCard"
        case .quartermaster:
            return "quartermasterSymbolCard"
        case .sunkeeper:
            return "sunkeeperSymbolCard"
        case .soothsinger:
            return "soothsingerSymbolCard"
        case .sawbones:
            return "sawbonesSymbolCard"
        case .berserker:
            return "berserkerSymbolCard"
        case .nightshroud:
            return "nightshroudSymbolCard"
        case .doomstalker:
            return "doomstalkerSymbolCard"
        case .beasttyrant:
            return "beasttyrantSymbolCard"
        case .summoner:
            return "summonerSymbolCard"
        case .plagueherald:
            return "plagueheraldSymbolCard"
        case .elementalist:
            return "elementalistSymbolCard"
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
        case .sunkeeper:
            return "sunkeeperCard"
        case .soothsinger:
            return "soothsingerCard"
        case .sawbones:
            return "sawbonesCard"
        case .berserker:
            return "berserkerCard"
        case .nightshroud:
            return "nightshroudCard"
        case .doomstalker:
            return "doomstalkerCard"
        case .beasttyrant:
            return "beasttyrantCard"
        case .summoner:
            return "summonerCard"
        case .plagueherald:
            return "plagueheraldCard"
        case .elementalist:
            return "elementalistCard"
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
        case .sunkeeper:
            return "sunkeeper"
        case .soothsinger:
            return "soothsinger"
        case .sawbones:
            return "sawbones"
        case .berserker:
            return "berserker"
        case .nightshroud:
            return "nightshroud"
        case .doomstalker:
            return "doomstalker"
        case .beasttyrant:
            return "beasttyrant"
        case .summoner:
            return "summoner"
        case .plagueherald:
            return "plagueherald"
        case .elementalist:
            return "elementalist"
        }
    }
    
        static func characterSymbolForClass(charClass: CharacterClass.charClass) -> String {
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
            case .sunkeeper:
                return "sunkeeperSymbol"
            case .soothsinger:
                return "soothsingerSymbol"
            case .sawbones:
                return "sawbonesSymbol"
            case .berserker:
                return "berserkerSymbol"
            case .nightshroud:
                return "nightshroudSymbol"
            case .doomstalker:
                return "doomstalkerSymbol"
            case .beasttyrant:
                return "beasttyrantSymbol"
            case .summoner:
                return "summonerSymbol"
            case .plagueherald:
                return "plagueheraldSymbol"
            case .elementalist:
                return "elementalistSymbol"
            }
        }
        
}

