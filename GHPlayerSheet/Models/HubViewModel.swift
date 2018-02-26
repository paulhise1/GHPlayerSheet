import Foundation
import UIKit
import FirebaseDatabase

protocol HubViewModelDelegate: class {
    func willCreateScenario(creator: String)
    func didCreateScenario(_ scenario: Scenario)
    func didCancelScenarioCreation()
}

class HubViewModel {
    
    struct Constant {
        static let pathComponent = "Player.plist"
    }
    weak var delegate: HubViewModelDelegate?
    let party: String
    private let playerDatasource: ModelDatasource<Player>?
    private(set) var player: Player?
    private(set) var service: ScenarioService
    private(set) var scenario: Scenario?
    private var difficulty: String?

    init() {
        //stubb
        party = "The Bridge Burners"
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.playerDatasource = ModelDatasource(with: url)
        
        self.service = FirebaseService(party: party)
        self.service.delegate = self
        loadPlayer()
    }
    
    func startScenarioCreation() {
        guard let player = player?.activeCharacter.name else { return }
        service.startScenarioCreation(party: party, playerName: player)
    }
    
    func activeCharacterImage() -> UIImage {
        guard let classType = player?.activeCharacter.classType, let playerImage = UIImage(named: ClassTypeData.characterImage(charClass: (classType))) else { return UIImage() }
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
    
    func ownedCharacters() -> [Character] {
        guard let player = player, let owned = player.ownedCharacters else { return [Character]() }
        return owned
    }
    
    private func loadPlayer() {
        guard let playerCheck = playerDatasource?.count() else { return }
        if playerCheck > 0 {
            self.player = playerDatasource?.modelAt(index: 0)
        }
    }
}

extension HubViewModel: ScenarioServiceDelegate {
    
    func willCreateScenario(hostName: String) {
        delegate?.willCreateScenario(creator: hostName)
    }
        
    func didCreateScenario(_ scenario: Scenario) {
        self.scenario = scenario
        delegate?.didCreateScenario(scenario)
    }
    
    func didCancelScenarioCreation() {
        delegate?.didCancelScenarioCreation()
    }
}
