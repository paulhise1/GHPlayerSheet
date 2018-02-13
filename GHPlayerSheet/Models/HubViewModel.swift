import Foundation
import UIKit
import FirebaseDatabase

class HubViewModel {
    
    struct Constant {
        static let pathComponent = "Player.plist"
    }
    
    private let party: String
    private let playerDatasource: ModelDatasource<Player>?
    private(set) var player: Player?

    init() {
        //stubb
        party = "The Funk Hunters"
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.playerDatasource = ModelDatasource(with: url)
        
        loadPlayer()
    }
    
    func activeCharacterImage() -> UIImage {
        guard let classType = player?.activeCharacter.classType, let playerImage = UIImage(named: ClassTypeData.icon(for: (classType))) else { return UIImage() }
        return playerImage
    }
    
    func addCharacterToPlayer(character: Character) {
        guard let player = player else {
            self.player = Player(activeCharacter: character, owndedCharacters: [character])
            playerDatasource?.update(model: self.player!)
            return
        }
        player.ownedCharacters?.append(character)
        player.activeCharacter = character
        playerDatasource?.update(model: player)
    }
    
    func setActiveCharacter(character: Character){
        guard let player = player else { return }
        player.activeCharacter = character
        playerDatasource?.update(model: player)
    }
    
    private func loadPlayer() {
        if let playerCheck = playerDatasource?.count() {
            if playerCheck > 0 {
                self.player = playerDatasource?.modelAt(index: 0)
            }
        }
    }
}
