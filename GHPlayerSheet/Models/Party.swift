import Foundation

class Party: Codable {
    var name: String
    var active: Bool
    
    init(name: String, active: Bool) {
        self.name = name
        self.active = active
    }
}
