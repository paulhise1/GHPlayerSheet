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
    private(set) var activeParty = Party(name: "Default", active: true)
    private let playerDatasource: ModelDatasource<Player>?
    private(set) var player: Player?

    init() {
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.playerDatasource = ModelDatasource(with: url)
        loadPlayer()
    }
    
    func createParty(partyName: String) {
        guard let player = player else { return }
        let party = Party(name: partyName, active: true)
        player.addPartyToParties(party: party)
        playerDatasource?.update(model: player)
        delegate?.didSetActiveParty(activeParty: party)
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
        guard let player = player else {
            return
        }
        player.addCharacterToCharacters(character: character)
        player.changeCharacterToActive(character: character)
        playerDatasource?.update(model: player)
    }
    
    func setActiveCharacter(character: Character){
        guard let player = player else { return }
        player.changeCharacterToActive(character: character)
        playerDatasource?.update(model: player)
    }
    
    func ownedCharacters() -> [Character] {
        guard let player = player, let owned = player.characters() else { return [Character]() }
        return owned
    }
    
    func writePlayerToDatasourceToSaveActiveCharacter() {
        guard let player = player else { return }
        playerDatasource?.update(model: player)
    }
    
    private func loadPlayer() {
        guard let playerCheck = playerDatasource?.count() else { return }
        if playerCheck > 0 {
            self.player = playerDatasource?.modelAt(index: 0)
            guard let activeParty = self.player?.activeParty() else { return }
            self.activeParty = activeParty
        } else if playerCheck == 0 {
            self.player = Player()
        }
    }
}
