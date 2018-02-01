import Foundation

struct Note: Codable, ModelProtocol {
    
    var text: String
    let creationDate: Date // Identifier
    var date: Date
    var identifier: Date {
        return creationDate
    }
    
    init(text: String, creationDate: Date, currentDate: Date) {
        self.text = text
        self.creationDate = creationDate
        self.date = currentDate
    }
}
