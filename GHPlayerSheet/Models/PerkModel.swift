import Foundation

class PerkModel {
    
    var perkText: String
    var perkAvailable: Int
    var checked: Bool?
    
    init(perk: String, perkCount: Int) {
        self.perkText = perk
        self.perkAvailable = perkCount
    }
    
    
}
