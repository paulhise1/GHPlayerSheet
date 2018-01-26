import Foundation

enum PerkListType {
    case brute
    case cragheart
    case mindthief
    case spellweaver
    case scoundrel
    case tinkerer
}

class PerkModel {
    
    var perkText: String
    var perkCount: Int
    
    init(perk: String, perkCount: Int) {
        self.perkText = perk
        self.perkCount = perkCount
    }
    
    enum AttackModifierSymbols: String {
        case negativeOne = "(-1)"
        case negativeTwo = "(-2)"
        case plusZero = "(+0)"
        case plusOne = "(+1)"
        case plusTwo = "(+2)"
        case plusThree = "(+3)"
        case rollingModifier = "<↷>"
        case push = "<→>"
        case pull = "<←>"
        case pierce = "<⤁>"
        case stun = "<*>"
        case disarm = "<👋🏽>"
        case muddle = "<?>"
        case addTarget = "<◎>"
        case shield = "🛡"
        case immobilize = "<🛑>"
        case curse = "<⚡️>"
        case wound = "<🚑>"
        case poison = "<☠️>"
        case invisible = "<👤>"
        case heal = "<❣️>"
        case fire = "(🔥)"
        case earth = "(🍃)"
        case air = "(💨)"
        case ice = "(❄️)"
        case light = "(🔆)"
        case dark = "(🌑)"
    }

}
