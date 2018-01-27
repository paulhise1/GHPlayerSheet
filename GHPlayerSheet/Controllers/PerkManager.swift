import Foundation

class PerkManager {
    
    func getPerkList(perksFor type: PerkListType) -> [PerkModel] {
        switch type {
        case .brute:
            
            let brutePerk1 = PerkModel(perk: "Remove two (-1) cards", perkCount: 1)
            let brutePerk2 = PerkModel(perk: "Replace one (-1) card with one (+1) card", perkCount: 1)
            let brutePerk3 = PerkModel(perk: "Add two (+1) cards", perkCount: 2)
            let brutePerk4 = PerkModel(perk: "Add one (+3) card", perkCount: 1)
            let brutePerk5 = PerkModel(perk: "Add three ↷ PUSH ⇢ 1 cards", perkCount: 2)
            let brutePerk6 = PerkModel(perk: "Add two ↷ PIERCE ⤁ 3 cards", perkCount: 1)
            let brutePerk7 = PerkModel(perk: "Add one ↷ STUN 💫 card", perkCount: 2)
            let brutePerk8 = PerkModel(perk: "Add one ↷ DISARM 👋🏽 card and one ↷ MUDDLE ❓ card", perkCount: 1)
            let brutePerk9 = PerkModel(perk: "Add one ↷ ADD TARGET ◎ card", perkCount: 2)
            let brutePerk10 = PerkModel(perk: "Add one (+1) Shield🛡1,Self card", perkCount: 1)
            let brutePerk11 = PerkModel(perk: "Ignore negative item effects and add one (+1) card", perkCount: 1)
            let brutePerkList = [brutePerk1, brutePerk2, brutePerk3, brutePerk4, brutePerk5, brutePerk6, brutePerk7, brutePerk8, brutePerk9, brutePerk10, brutePerk11]
            return brutePerkList
        
        case .cragheart:
            let cragheartPerk1 = PerkModel(perk: "Remove four (+0) cards", perkCount: 1)
            let cragheartPerk2 = PerkModel(perk: "Replace one (-1) card with one (+1) card", perkCount: 3)
            let cragheartPerk3 = PerkModel(perk: "Add one (-2) card and two (+2) cards", perkCount: 1)
            let cragheartPerk4 = PerkModel(perk: "Add one (+1) IMMOBILIZE 🚷 card", perkCount: 2)
            let cragheartPerk5 = PerkModel(perk: "Add one (+2) MUDDLE ❓ card", perkCount: 2)
            let cragheartPerk6 = PerkModel(perk: "Add two ↷ PUSH ⇢ 2 cards", perkCount: 1)
            let cragheartPerk7 = PerkModel(perk: "Add two ↷ 🍃 cards", perkCount: 2)
            let cragheartPerk8 = PerkModel(perk: "Add two ↷ 💨 cards", perkCount: 1)
            let cragheartPerk9 = PerkModel(perk: "Ignore negative item effects", perkCount: 1)
            let cragheartPerk10 = PerkModel(perk: "Ignore negative scenario effects", perkCount: 1)
            let cragheartPerkList = [cragheartPerk1, cragheartPerk2, cragheartPerk3, cragheartPerk4, cragheartPerk5, cragheartPerk6, cragheartPerk7, cragheartPerk8, cragheartPerk9, cragheartPerk10]
            return cragheartPerkList
            
        case .mindthief:
            let mindthiefPerk1 = PerkModel(perk: "Remove two (-1) cards", perkCount: 2)
            let mindthiefPerk2 = PerkModel(perk: "Remove four (+0) cards", perkCount: 1)
            let mindthiefPerk3 = PerkModel(perk: "Replace two (+1) card with one (+2) card", perkCount: 1)
            let mindthiefPerk4 = PerkModel(perk: "Replace one (-2) card with one (+0) card", perkCount: 1)
            let mindthiefPerk5 = PerkModel(perk: "Add one (+2) ❄️ card", perkCount: 2)
            let mindthiefPerk6 = PerkModel(perk: "Add two ↷ (+1) cards", perkCount: 2)
            let mindthiefPerk7 = PerkModel(perk: "Add three ↷ Pull ⇠ 1 cards", perkCount: 1)
            let mindthiefPerk8 = PerkModel(perk: "Add three ↷ MUDDLE ❓ cards", perkCount: 1)
            let mindthiefPerk9 = PerkModel(perk: "Add two ↷ IMMOBILIZE 🚷 cards", perkCount: 1)
            let mindthiefPerk10 = PerkModel(perk: "Add one ↷ STUN 💫 card", perkCount: 1)
            let mindthiefPerk11 = PerkModel(perk: "Add one ↷ DISARM 👋🏽 card and one ↷ MUDDLE ❓ card", perkCount: 1)
            let mindthiefPerk12 = PerkModel(perk: "Ignore negative scenario effects", perkCount: 1)
            let mindthiefPerkList = [mindthiefPerk1, mindthiefPerk2, mindthiefPerk3, mindthiefPerk4, mindthiefPerk5, mindthiefPerk6, mindthiefPerk7, mindthiefPerk8, mindthiefPerk9, mindthiefPerk10, mindthiefPerk11, mindthiefPerk12]
            return mindthiefPerkList
            
        case .spellweaver:
            let spellweaverPerk1 = PerkModel(perk: "Remove four (+0) cards", perkCount: 1)
            let spellweaverPerk2 = PerkModel(perk: "Replace one (-1) card with one (+1) card", perkCount: 2)
            let spellweaverPerk3 = PerkModel(perk: "Add two (+1) cards", perkCount: 2)
            let spellweaverPerk4 = PerkModel(perk: "Add one (+0) STUN 💫 card", perkCount: 1)
            let spellweaverPerk5 = PerkModel(perk: "Add one (+1) WOUND 🚑 card", perkCount: 1)
            let spellweaverPerk6 = PerkModel(perk: "Add one (+1) IMMOBILIZE 🚷 card", perkCount: 1)
            let spellweaverPerk7 = PerkModel(perk: "Add one (+1) CURSE ⚡️ card", perkCount: 1)
            let spellweaverPerk8 = PerkModel(perk: "Add one (+2) 🔥 card", perkCount: 2)
            let spellweaverPerk9 = PerkModel(perk: "Add one (+2) ❄️ card", perkCount: 2)
            let spellweaverPerk10 = PerkModel(perk: "Add one ↷ 🍃 and one ↷ 💨 card", perkCount: 1)
            let spellweaverPerk11 = PerkModel(perk: "Add one ↷ 🔆 and one ↷ 🌑 card", perkCount: 1)
            let spellweaverPerkList = [spellweaverPerk1, spellweaverPerk2, spellweaverPerk3, spellweaverPerk4, spellweaverPerk5, spellweaverPerk6, spellweaverPerk7, spellweaverPerk8, spellweaverPerk9, spellweaverPerk10, spellweaverPerk11]
            return spellweaverPerkList
            
        case .scoundrel:
            let scoundrelPerk1 = PerkModel(perk: "Remove two (-1) cards", perkCount: 2)
            let scoundrelPerk2 = PerkModel(perk: "Remove four (+0) cards", perkCount: 1)
            let scoundrelPerk3 = PerkModel(perk: "Replace one (-2) card with one (+0) card", perkCount: 1)
            let scoundrelPerk4 = PerkModel(perk: "Replace one (-1) card with one (+1) card", perkCount: 1)
            let scoundrelPerk5 = PerkModel(perk: "Replace one (+0) card with one (+2) card", perkCount: 2)
            let scoundrelPerk6 = PerkModel(perk: "Add two ↷ (+1) cards", perkCount: 2)
            let scoundrelPerk7 = PerkModel(perk: "Add two ↷ PIERCE ⤁ 3 cards", perkCount: 1)
            let scoundrelPerk8 = PerkModel(perk: "Add two ↷ ☠️ cards", perkCount: 2)
            let scoundrelPerk9 = PerkModel(perk: "Add two ↷ MUDDLE ❓ cards", perkCount: 1)
            let scoundrelPerk10 = PerkModel(perk: "Add one ↷ INVISIBLE 👤 cards", perkCount: 1)
            let scoundrelPerk11 = PerkModel(perk: "Ignore negative scenario effects", perkCount: 1)
            let scoundrelPerkList = [scoundrelPerk1, scoundrelPerk2, scoundrelPerk3, scoundrelPerk4, scoundrelPerk5, scoundrelPerk6, scoundrelPerk7, scoundrelPerk8, scoundrelPerk9, scoundrelPerk10, scoundrelPerk11]
            return scoundrelPerkList
            
        case .tinkerer:
            let tinkererPerk1 = PerkModel(perk: "Remove two (-1) cards", perkCount: 2)
            let tinkererPerk2 = PerkModel(perk: "Replace one (-2) card with one (+0) card", perkCount: 1)
            let tinkererPerk3 = PerkModel(perk: "Add two (+1) cards", perkCount: 1)
            let tinkererPerk4 = PerkModel(perk: "Add one (+3) card", perkCount: 1)
            let tinkererPerk5 = PerkModel(perk: "Add two ↷ 🔥 cards", perkCount: 1)
            let tinkererPerk6 = PerkModel(perk: "Add three ↷ MUDDLE ❓ cards", perkCount: 1)
            let tinkererPerk7 = PerkModel(perk: "Add one (+1) WOUND 🚑 card", perkCount: 2)
            let tinkererPerk8 = PerkModel(perk: "Add one (+1) IMMOBILIZE 🚷 card", perkCount: 2)
            let tinkererPerk9 = PerkModel(perk: "Add one (+1) HEAL ❣️ 2 card", perkCount: 2)
            let tinkererPerk10 = PerkModel(perk: "Add one (+0) ADD TARGET ◎ card", perkCount: 1)
            let tinkererPerk11 = PerkModel(perk: "Ignore negative scenario effects", perkCount: 1)
            let tinkererPerkList = [tinkererPerk1, tinkererPerk2, tinkererPerk3, tinkererPerk4, tinkererPerk5, tinkererPerk6, tinkererPerk7, tinkererPerk8, tinkererPerk9, tinkererPerk10, tinkererPerk11]
            return tinkererPerkList
        }
    }
}
