import UIKit

enum ClassType : String, Codable {
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

class ClassTypeData {
    
    static let startingClasses = [ClassType.cragheart,  ClassType.tinkerer,  ClassType.mindthief, ClassType.scoundrel, ClassType.spellweaver, ClassType.brute]
    static let remainingClasses = [ClassType.quartermaster, ClassType.sunkeeper, ClassType.soothsinger, ClassType.sawbones, ClassType.berserker, ClassType.nightshroud, ClassType.doomstalker, ClassType.beasttyrant, ClassType.summoner, ClassType.plagueherald, ClassType.elementalist]
    static let allClasses = ClassTypeData.startingClasses + ClassTypeData.remainingClasses
    
    static func health(for classType: ClassType, level: Int) -> Int {
        let lowHealth = [6,7,8,9,10,11,12,13,14]
        let medHealth = [8,9,11,12,14,15,17,18,20]
        let highHealth = [10,12,14,16,18,20,22,24,26]
        
        switch classType {
        case .cragheart:
            return highHealth[level-1]
        case .scoundrel:
            return medHealth[level-1]
        case .tinkerer:
            return medHealth[level-1]
        case .mindthief:
            return lowHealth[level-1]
        case .spellweaver:
            return lowHealth[level-1]
        case .brute:
            return highHealth[level-1]
        case .quartermaster:
            return highHealth[level-1]
        case .sunkeeper:
            return highHealth[level-1]
        case .soothsinger:
            return lowHealth[level-1]
        case .sawbones:
            return medHealth[level-1]
        case .berserker:
            return highHealth[level-1]
        case .nightshroud:
            return medHealth[level-1]
        case .doomstalker:
            return medHealth[level-1]
        case .beasttyrant:
            return lowHealth[level-1]
        case .summoner:
            return medHealth[level-1]
        case .plagueherald:
            return lowHealth[level-1]
        case .elementalist:
            return lowHealth[level-1]
        }
    }
    
    static func level(for experience: Int) -> Int {
        switch experience {
        case 0...44:
            return 1
        case 45...94:
            return 2
        case 95...149:
            return 3
        case 150...209:
            return 4
        case 210...274:
            return 5
        case 275...344:
            return 6
        case 345...419:
            return 7
        case 420...499:
            return 8
        default:
            return 9
        }
    }
    
    static func characterColor(charClass: ClassType) -> UIColor {
        switch charClass {
        case .cragheart:
            return ColorConstants.cragheart
        case .brute:
            return ColorConstants.brute
        case .mindthief:
            return ColorConstants.mindthief
        case .scoundrel:
            return ColorConstants.scoundrel
        case .spellweaver:
            return ColorConstants.spellweaver
        case .tinkerer:
            return ColorConstants.tinkerer
        case .quartermaster:
            return ColorConstants.quartermaster
        case .sunkeeper:
            return ColorConstants.sunkeeper
        case .soothsinger:
            return ColorConstants.soothsinger
        case .sawbones:
            return ColorConstants.sawbones
        case .berserker:
            return ColorConstants.berserker
        case .nightshroud:
            return ColorConstants.nightshroud
        case .doomstalker:
            return ColorConstants.doomstalker
        case .beasttyrant:
            return ColorConstants.beasttyrant
        case .summoner:
            return ColorConstants.summoner
        case .plagueherald:
            return ColorConstants.plagueherald
        case .elementalist:
            return ColorConstants.elementalist
        }
    }

    
    static func characterImage(charClass: ClassType) -> String {
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
    
    static func CharacterFullImage(for classType: ClassType) -> UIImage? {
        switch classType {
        case .cragheart:
            return UIImage(named: "cragheartFull")
        case .brute:
            return UIImage(named: "bruteFull")
        case .mindthief:
            return UIImage(named: "mindthiefFull")
        case .scoundrel:
            return UIImage(named: "scoundrelFull")
        case .spellweaver:
            return UIImage(named: "spellweaverFull")
        case .tinkerer:
            return UIImage(named: "tinkererFull")
        case .quartermaster:
            return UIImage(named: "quartermasterFull")
        case .sunkeeper:
            return UIImage(named: "sunkeeperFull")
        case .soothsinger:
            return UIImage(named: "soothsingerFull")
        case .sawbones:
            return UIImage(named: "sawbonesFull")
        case .berserker:
            return UIImage(named: "berserkerFull")
        case .nightshroud:
            return UIImage(named: "nightshroudFull")
        case .doomstalker:
            return UIImage(named: "doomstalkerFull")
        case .beasttyrant:
            return UIImage(named: "beasttyrantFull")
        case .summoner:
            return UIImage(named: "summonerFull")
        case .plagueherald:
            return UIImage(named: "plagueheraldFull")
        case .elementalist:
            return UIImage(named: "elementalistFull")
        }
    }
    
    static func icon(for classType: ClassType) -> String {
        switch classType {
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
    
    static func colorIcon(for classType: ClassType) -> UIImage? {
        switch classType {
        case .cragheart:
            return UIImage(named: "cragheartColorSymbol")
        case .brute:
            return UIImage(named: "bruteColorSymbol")
        case .mindthief:
            return UIImage(named: "mindthiefColorSymbol")
        case .scoundrel:
            return UIImage(named: "scoundrelColorSymbol")
        case .spellweaver:
            return UIImage(named: "spellweaverColorSymbol")
        case .tinkerer:
            return UIImage(named: "tinkererColorSymbol")
        case .quartermaster:
            return UIImage(named: "quartermasterColorSymbol")
        case .sunkeeper:
            return UIImage(named: "sunkeeperColorSymbol")
        case .soothsinger:
            return UIImage(named: "soothsingerColorSymbol")
        case .sawbones:
            return UIImage(named: "sawbonesColorSymbol")
        case .berserker:
            return UIImage(named: "berserkerColorSymbol")
        case .nightshroud:
            return UIImage(named: "nightshroudColorSymbol")
        case .doomstalker:
            return UIImage(named: "doomstalkerColorSymbol")
        case .beasttyrant:
            return UIImage(named: "beasttyrantColorSymbol")
        case .summoner:
            return UIImage(named: "summonerColorSymbol")
        case .plagueherald:
            return UIImage(named: "plagueheraldColorSymbol")
        case .elementalist:
            return UIImage(named: "elementalistColorSymbol")
        }
    }
    
    //    static func characterLockedImageForClass(charClass: ClassType) -> String {
    //        switch charClass {
    //        case .cragheart:
    //            return "cragheartSymbolCard"
    //        case .brute:
    //            return "bruteSymbolCard"
    //        case .mindthief:
    //            return "mindthiefSymbolCard"
    //        case .scoundrel:
    //            return "scoundrelSymbolCard"
    //        case .spellweaver:
    //            return "spellweaverSymbolCard"
    //        case .tinkerer:
    //            return "tinkererSymbolCard"
    //        case .quartermaster:
    //            return "quartermasterSymbolCard"
    //        case .sunkeeper:
    //            return "sunkeeperSymbolCard"
    //        case .soothsinger:
    //            return "soothsingerSymbolCard"
    //        case .sawbones:
    //            return "sawbonesSymbolCard"
    //        case .berserker:
    //            return "berserkerSymbolCard"
    //        case .nightshroud:
    //            return "nightshroudSymbolCard"
    //        case .doomstalker:
    //            return "doomstalkerSymbolCard"
    //        case .beasttyrant:
    //            return "beasttyrantSymbolCard"
    //        case .summoner:
    //            return "summonerSymbolCard"
    //        case .plagueherald:
    //            return "plagueheraldSymbolCard"
    //        case .elementalist:
    //            return "elementalistSymbolCard"
    //        }
    //    }
    
    //    static func characterCardBackImage(charClass: ClassType) -> String {
    //        switch charClass {
    //        case .cragheart:
    //            return "cragheartCard"
    //        case .brute:
    //            return "bruteCard"
    //        case .mindthief:
    //            return "mindthiefCard"
    //        case .scoundrel:
    //            return "scoundrelCard"
    //        case .spellweaver:
    //            return "spellweaverCard"
    //        case .tinkerer:
    //            return "tinkererCard"
    //        case .quartermaster:
    //            return "quartermasterCard"
    //        case .sunkeeper:
    //            return "sunkeeperCard"
    //        case .soothsinger:
    //            return "soothsingerCard"
    //        case .sawbones:
    //            return "sawbonesCard"
    //        case .berserker:
    //            return "berserkerCard"
    //        case .nightshroud:
    //            return "nightshroudCard"
    //        case .doomstalker:
    //            return "doomstalkerCard"
    //        case .beasttyrant:
    //            return "beasttyrantCard"
    //        case .summoner:
    //            return "summonerCard"
    //        case .plagueherald:
    //            return "plagueheraldCard"
    //        case .elementalist:
    //            return "elementalistCard"
    //        }
    //    }
}
