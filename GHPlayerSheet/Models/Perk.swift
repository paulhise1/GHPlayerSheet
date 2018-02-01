import Foundation

class Perk {
    
    var perkText: String
    var perkAvailable: Int
    var checked: Bool?
    
    init(perk: String, perkCount: Int) {
        self.perkText = perk
        self.perkAvailable = perkCount
    }
    
    static func perksList(perksFor type: CharacterClass) -> [Perk] {
        switch type {
        case .brute:
            
            let brutePerk1 = Perk(perk: "Remove two (-1) cards", perkCount: 1)
            brutePerk1.checked = false
            let brutePerk2 = Perk(perk: "Replace one (-1) card with one (+1) card", perkCount: 1)
            brutePerk2.checked = false
            let brutePerk3 = Perk(perk: "Add two (+1) cards", perkCount: 2)
            brutePerk3.checked = false
            let brutePerk4 = Perk(perk: "Add one (+3) card", perkCount: 1)
            brutePerk4.checked = false
            let brutePerk5 = Perk(perk: "Add three ↷ PUSH ⇢ 1 cards", perkCount: 2)
            brutePerk5.checked = false
            let brutePerk6 = Perk(perk: "Add two ↷ PIERCE ⤁ 3 cards", perkCount: 1)
            brutePerk6.checked = false
            let brutePerk7 = Perk(perk: "Add one ↷ STUN 💫 card", perkCount: 2)
            brutePerk7.checked = false
            let brutePerk8 = Perk(perk: "Add one ↷ DISARM 👋🏽 card and one ↷ MUDDLE ❓ card", perkCount: 1)
            brutePerk8.checked = false
            let brutePerk9 = Perk(perk: "Add one ↷ ADD TARGET ◎ card", perkCount: 2)
            brutePerk9.checked = false
            let brutePerk10 = Perk(perk: "Add one (+1) Shield🛡1,Self card", perkCount: 1)
            brutePerk10.checked = false
            let brutePerk11 = Perk(perk: "Ignore negative item effects and add one (+1) card", perkCount: 1)
            brutePerk11.checked = false
            let brutePerkList = [brutePerk1, brutePerk2, brutePerk3, brutePerk4, brutePerk5, brutePerk6, brutePerk7, brutePerk8, brutePerk9, brutePerk10, brutePerk11]
            return brutePerkList
            
        case .Cragheart:
            let cragheartPerk1 = Perk(perk: "Remove four (+0) cards", perkCount: 1)
            let cragheartPerk2 = Perk(perk: "Replace one (-1) card with one (+1) card", perkCount: 3)
            let cragheartPerk3 = Perk(perk: "Add one (-2) card and two (+2) cards", perkCount: 1)
            let cragheartPerk4 = Perk(perk: "Add one (+1) IMMOBILIZE 🚷 card", perkCount: 2)
            let cragheartPerk5 = Perk(perk: "Add one (+2) MUDDLE ❓ card", perkCount: 2)
            let cragheartPerk6 = Perk(perk: "Add two ↷ PUSH ⇢ 2 cards", perkCount: 1)
            let cragheartPerk7 = Perk(perk: "Add two ↷ 🍃 cards", perkCount: 2)
            let cragheartPerk8 = Perk(perk: "Add two ↷ 💨 cards", perkCount: 1)
            let cragheartPerk9 = Perk(perk: "Ignore negative item effects", perkCount: 1)
            let cragheartPerk10 = Perk(perk: "Ignore negative scenario effects", perkCount: 1)
            let cragheartPerkList = [cragheartPerk1, cragheartPerk2, cragheartPerk3, cragheartPerk4, cragheartPerk5, cragheartPerk6, cragheartPerk7, cragheartPerk8, cragheartPerk9, cragheartPerk10]
            return cragheartPerkList
            
        case .mindthief:
            let mindthiefPerk1 = Perk(perk: "Remove two (-1) cards", perkCount: 2)
            let mindthiefPerk2 = Perk(perk: "Remove four (+0) cards", perkCount: 1)
            let mindthiefPerk3 = Perk(perk: "Replace two (+1) card with one (+2) card", perkCount: 1)
            let mindthiefPerk4 = Perk(perk: "Replace one (-2) card with one (+0) card", perkCount: 1)
            let mindthiefPerk5 = Perk(perk: "Add one (+2) ❄️ card", perkCount: 2)
            let mindthiefPerk6 = Perk(perk: "Add two ↷ (+1) cards", perkCount: 2)
            let mindthiefPerk7 = Perk(perk: "Add three ↷ Pull ⇠ 1 cards", perkCount: 1)
            let mindthiefPerk8 = Perk(perk: "Add three ↷ MUDDLE ❓ cards", perkCount: 1)
            let mindthiefPerk9 = Perk(perk: "Add two ↷ IMMOBILIZE 🚷 cards", perkCount: 1)
            let mindthiefPerk10 = Perk(perk: "Add one ↷ STUN 💫 card", perkCount: 1)
            let mindthiefPerk11 = Perk(perk: "Add one ↷ DISARM 👋🏽 card and one ↷ MUDDLE ❓ card", perkCount: 1)
            let mindthiefPerk12 = Perk(perk: "Ignore negative scenario effects", perkCount: 1)
            let mindthiefPerkList = [mindthiefPerk1, mindthiefPerk2, mindthiefPerk3, mindthiefPerk4, mindthiefPerk5, mindthiefPerk6, mindthiefPerk7, mindthiefPerk8, mindthiefPerk9, mindthiefPerk10, mindthiefPerk11, mindthiefPerk12]
            return mindthiefPerkList
            
        case .spellweaver:
            let spellweaverPerk1 = Perk(perk: "Remove four (+0) cards", perkCount: 1)
            let spellweaverPerk2 = Perk(perk: "Replace one (-1) card with one (+1) card", perkCount: 2)
            let spellweaverPerk3 = Perk(perk: "Add two (+1) cards", perkCount: 2)
            let spellweaverPerk4 = Perk(perk: "Add one (+0) STUN 💫 card", perkCount: 1)
            let spellweaverPerk5 = Perk(perk: "Add one (+1) WOUND 🚑 card", perkCount: 1)
            let spellweaverPerk6 = Perk(perk: "Add one (+1) IMMOBILIZE 🚷 card", perkCount: 1)
            let spellweaverPerk7 = Perk(perk: "Add one (+1) CURSE ⚡️ card", perkCount: 1)
            let spellweaverPerk8 = Perk(perk: "Add one (+2) 🔥 card", perkCount: 2)
            let spellweaverPerk9 = Perk(perk: "Add one (+2) ❄️ card", perkCount: 2)
            let spellweaverPerk10 = Perk(perk: "Add one ↷ 🍃 and one ↷ 💨 card", perkCount: 1)
            let spellweaverPerk11 = Perk(perk: "Add one ↷ 🔆 and one ↷ 🌑 card", perkCount: 1)
            let spellweaverPerkList = [spellweaverPerk1, spellweaverPerk2, spellweaverPerk3, spellweaverPerk4, spellweaverPerk5, spellweaverPerk6, spellweaverPerk7, spellweaverPerk8, spellweaverPerk9, spellweaverPerk10, spellweaverPerk11]
            return spellweaverPerkList
            
        case .scoundrel:
            let scoundrelPerk1 = Perk(perk: "Remove two (-1) cards", perkCount: 2)
            let scoundrelPerk2 = Perk(perk: "Remove four (+0) cards", perkCount: 1)
            let scoundrelPerk3 = Perk(perk: "Replace one (-2) card with one (+0) card", perkCount: 1)
            let scoundrelPerk4 = Perk(perk: "Replace one (-1) card with one (+1) card", perkCount: 1)
            let scoundrelPerk5 = Perk(perk: "Replace one (+0) card with one (+2) card", perkCount: 2)
            let scoundrelPerk6 = Perk(perk: "Add two ↷ (+1) cards", perkCount: 2)
            let scoundrelPerk7 = Perk(perk: "Add two ↷ PIERCE ⤁ 3 cards", perkCount: 1)
            let scoundrelPerk8 = Perk(perk: "Add two ↷ ☠️ cards", perkCount: 2)
            let scoundrelPerk9 = Perk(perk: "Add two ↷ MUDDLE ❓ cards", perkCount: 1)
            let scoundrelPerk10 = Perk(perk: "Add one ↷ INVISIBLE 👤 cards", perkCount: 1)
            let scoundrelPerk11 = Perk(perk: "Ignore negative scenario effects", perkCount: 1)
            let scoundrelPerkList = [scoundrelPerk1, scoundrelPerk2, scoundrelPerk3, scoundrelPerk4, scoundrelPerk5, scoundrelPerk6, scoundrelPerk7, scoundrelPerk8, scoundrelPerk9, scoundrelPerk10, scoundrelPerk11]
            return scoundrelPerkList
            
        case .tinkerer:
            let tinkererPerk1 = Perk(perk: "Remove two (-1) cards", perkCount: 2)
            let tinkererPerk2 = Perk(perk: "Replace one (-2) card with one (+0) card", perkCount: 1)
            let tinkererPerk3 = Perk(perk: "Add two (+1) cards", perkCount: 1)
            let tinkererPerk4 = Perk(perk: "Add one (+3) card", perkCount: 1)
            let tinkererPerk5 = Perk(perk: "Add two ↷ 🔥 cards", perkCount: 1)
            let tinkererPerk6 = Perk(perk: "Add three ↷ MUDDLE ❓ cards", perkCount: 1)
            let tinkererPerk7 = Perk(perk: "Add one (+1) WOUND 🚑 card", perkCount: 2)
            let tinkererPerk8 = Perk(perk: "Add one (+1) IMMOBILIZE 🚷 card", perkCount: 2)
            let tinkererPerk9 = Perk(perk: "Add one (+1) HEAL ❣️ 2 card", perkCount: 2)
            let tinkererPerk10 = Perk(perk: "Add one (+0) ADD TARGET ◎ card", perkCount: 1)
            let tinkererPerk11 = Perk(perk: "Ignore negative scenario effects", perkCount: 1)
            let tinkererPerkList = [tinkererPerk1, tinkererPerk2, tinkererPerk3, tinkererPerk4, tinkererPerk5, tinkererPerk6, tinkererPerk7, tinkererPerk8, tinkererPerk9, tinkererPerk10, tinkererPerk11]
            return tinkererPerkList
        }
    }
    
    enum AttackModifierSymbols: String {
        case negativeOne = "(-1)"
        case negativeTwo = "(-2)"
        case plusZero = "(+0)"
        case plusOne = "(+1)"
        case plusTwo = "(+2)"
        case plusThree = "(+3)"
        case rollingModifier = "↷"
        case push = "⇢"
        case pull = "⇠"
        case pierce = "⤁"
        case stun = "💫"
        case disarm = "👋🏽"
        case muddle = "❓"
        case addTarget = "◎"
        case shield = "🛡"
        case immobilize = "🚷"
        case curse = "⚡️"
        case wound = "🚑"
        case poison = "☠️"
        case invisible = "👤"
        case heal = "❣️"
        case fire = "🔥"
        case earth = "🍃"
        case air = "💨"
        case ice = "❄️"
        case light = "🔆"
        case dark = "🌑"
    }
}
