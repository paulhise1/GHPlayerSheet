import Foundation
import UIKit // Delete when stub name is gone
import FirebaseDatabase

protocol HubViewModelDelegate: class {
    func updateJoinScenarioLabel(scenarioLabelText: String)
}

class HubViewModel: ScenarioServiceDelegate {
    
    struct Constant {
        static let pathComponent = "characters.plist"
        static let playerKey = "players"
        static let scenarioKey = "scenario"
    }
    
    weak var delegate: HubViewModelDelegate?
    
    private(set) var scenarioService: ScenarioService
    private var characterDatasource: ModelDatasource<CharacterModel>?
    
    var name: String {
        return character.name
    }
    
    var health: String {
        return character.health
    }
    
    private var character: CharacterModel
    let partyName = "The Funk Hunters"
    
    init() {
        self.character = CharacterModel(characterClass: .brute, creationDate: Date(), gold: 30, experience: 0)
        let name = UIDevice.current.name
        self.character.updateName(name: name)
        
        self.scenarioService = FirebaseService(partyName: partyName)
        self.scenarioService.delegate = self
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.characterDatasource = ModelDatasource(with: url)
    }
    
    func startScenario(number: String) {
        scenarioService.createScenario(partyName: partyName, number: number)
    }
    
//    func addScenarioListener() {
//        scenarioService.addScenarioListener()
//    }
    
    func didGetScenarioNumber(scenarioNumber: String) {
        guard let scenarioName = Scenario.scenarioFromNumber(scenarioNumber)?.name else { return }
        let scenarioLableText = "# \(scenarioNumber): \(scenarioName)"
        delegate?.updateJoinScenarioLabel(scenarioLabelText: scenarioLableText)
    }
    
    func didUpdatePlayers(players: [Player]) {
        // just need this to conform to delegate so I can get the scenarioNumber Info
    }
}
