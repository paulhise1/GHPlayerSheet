import Foundation

class Player: Codable, ModelProtocol {
    
    private var parties = [Party]()
    private var ownedCharacters: [Character]?
    var identifier: Date
    
    init(identifier: Date = Date()) {
        self.identifier = identifier
    }
    
    // MARK: Character Methods
    func addCharacterToCharacters(character: Character) {
        ownedCharacters?.append(character)
    }
    
    func removeCharacterFromCharacters(character: Character) {
        ownedCharacters = ownedCharacters?.filter{ $0 != character}
    }
    
    func characters() -> [Character]? {
        return ownedCharacters
    }
    
    func activeCharacter() -> Character? {
        guard let characters = self.ownedCharacters else { return nil }
        for character in characters {
            if character.active {
                return character
            }
        }
        return nil
    }
    
    func changeCharacterToActive(character: Character) {
        removeCharacterFromCharacters(character: character)
        guard let characters = self.ownedCharacters else { return }
        for character in characters {
            if character.active {
                character.active = false
            }
        }
        character.active = true
        addCharacterToCharacters(character: character)
    }
    
    // MARK: Party Methods
    func addPartyToParties(party: Party) {
        parties.append(party)
        parties = parties.filter{ $0.name != "Default" }
    }

    func removePartyFromParties(party: Party) {
        parties = parties.filter{ $0.name != party.name }
    }

    func activeParty() -> Party? {
        for party in parties {
            if party.active {
                return party
            }
        }
        return nil
        
    }
    
    func changePartyToActive(_ partyToActivate: Party) {
        removePartyFromParties(party: partyToActivate)
        for party in parties {
            if party.active {
                party.active = false
            }
        }
        partyToActivate.active = true
        addPartyToParties(party: partyToActivate)
    }
}
