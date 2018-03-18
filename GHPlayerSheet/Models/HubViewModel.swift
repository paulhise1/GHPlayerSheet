import UIKit
import FirebaseDatabase

protocol HubViewModelDelegate: class {
    func didSetActiveParty(activeParty: Party)
}

class HubViewModel {
    
    struct Constant {
        static let pathComponent = "Player.plist"
    }
    weak var delegate: HubViewModelDelegate?
    private let playerDatasource: ModelDatasource<Player>?
    private(set) var player: Player?

    init() {
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.playerDatasource = ModelDatasource(with: url)
        loadPlayer()
    }
    
    func createParty(partyName: String) {
        guard let player = player else { return }
        player.createPartyWithName(partyName)
        playerDatasource?.update(model: player)
        guard let party = player.activeParty() else { return }
        delegate?.didSetActiveParty(activeParty: party)
    }
    
    func deleteParty(party: Party) {
        player?.deleteParty(party: party)
        saveChangesToPlayer()
    }
    
    func activeParty() -> Party? {
        guard let party = player?.activeParty() else { return nil }
        return party
    }
    
    func activeCharacterSymbol() -> UIImage {
        guard let classType = player?.activeCharacter()?.classType, let playerImage = ClassTypeData.colorIcon(for: (classType)) else { return UIImage() }
        return playerImage
    }
    
    func activeCharacterType() -> ClassType? {
        guard let activeCharacterType = player?.activeCharacter()?.classType else { return nil }
        return activeCharacterType
    }
    
    func activeCharacterLevelString() -> String? {
        guard let activeCharacterLevel = player?.activeCharacter()?.level else { return nil }
        return String(activeCharacterLevel)
    }
    
    func activeCharacterTypeString() -> String? {
        guard let activeCharacterTypeString = player?.activeCharacter()?.classType.rawValue else { return nil }
        return activeCharacterTypeString
    }
    
    func activeCharacterColorIcon() -> UIImage {
        guard let classType = player?.activeCharacter()?.classType, let playerImage = ClassTypeData.colorIcon(for: (classType)) else { return UIImage() }
        return playerImage
    }
    
    func addCharacterToPlayer(character: Character) {
        guard let player = player else { return }
        player.addCharacterToCharacters(character: character)
        setActiveCharacter(character: character)
    }
    
    func setActiveParty(_ party: Party) {
        guard let player = player else { return }
        player.changePartyToActive(party)
        saveChangesToPlayer()
        delegate?.didSetActiveParty(activeParty: party)
    }
    
    func setActiveCharacter(character: Character) {
        guard let player = player else { return }
        player.changeCharacterToActive(character: character)
        saveChangesToPlayer()
    }
    
    func ownedCharacters() -> [Character] {
        guard let player = player, let owned = player.characters() else { return [Character]() }
        return owned
    }
    
    func saveChangesToPlayer() {
        guard let player = player else { return }
        playerDatasource?.update(model: player)
    }
    
    private func loadPlayer() {
        guard let playerCheck = playerDatasource?.count() else { return }
        if playerCheck > 0 {
            self.player = playerDatasource?.modelAt(index: 0)
        } else if playerCheck == 0 {
            self.player = Player()
        }
    }
}
