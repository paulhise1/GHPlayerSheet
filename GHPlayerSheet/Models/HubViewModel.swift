import Foundation
import UIKit
import FirebaseDatabase

protocol HubViewModelDelegate: class {
    func updateScenarioInfo(scenarioLabelText: String)
}

class HubViewModel: ScenarioServiceDelegate {
    
    struct Constant {
        static let pathComponent = "characters.plist"
        static let playerKey = "players"
        static let scenarioKey = "scenario"
    }
    
    weak var delegate: HubViewModelDelegate?
    
    private var character: Character?
    private(set) var partyName: String?
    private(set) var scenarioService: ScenarioService
    private(set) var characterDatasource: ModelDatasource<Character>?
    
    var name: String {
        guard let char = character else { return "" }
        return char.name
    }
    
    var health: String {
        guard let char = character else { return "0" }
        return char.health
    }
    
    var characterClassCount: Int {
        return Character.classes.count
    }
    
    init() {
        //stub
        scenarioService = FirebaseService(partyName: partyName)
        scenarioService.delegate = self
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.characterDatasource = ModelDatasource(with: url)
        print(url ?? "Could not print character.plist URL")
    }
    
    func loadCharacterFromPList(){
        guard let characterCount = characterDatasource?.count() else { return }
        guard characterCount > 0 else { return }
        character = characterDatasource?.modelAt(index: 0) 
    }
    
    func updateParty(partyname: String) {
        self.partyName = partyname
        guard let party = partyName else { return }
        scenarioService.updatePartyName(partyName: party)
    }
    
    func characterInfoForLabel() -> String {
        guard let char = character else { return "No character info available" }
        return "\(char.name): Level \(char.level) \(char.characterClass.rawValue)"
    }
    
    func partyNameForLabel() -> String {
        guard let party = partyName else { return "No party info available"}
        return party
    }
    func startScenario(number: String) {
        guard let party = partyName else { return }
        scenarioService.createScenario(partyName: party, number: number)
    }
    
    func didGetScenarioNumber(scenarioNumber: String) {
        guard let scenarioName = Scenario.scenarioFromNumber(scenarioNumber)?.name else { return }
        let scenarioLableText = "# \(scenarioNumber): \(scenarioName)"
        delegate?.updateScenarioInfo(scenarioLabelText: scenarioLableText)
    }
    
    func createCharacter(charClass: CharacterClass, name: String, experience: Int) {
        character = Character(characterClass: charClass, name: name)
        guard let char = character else { return }
        char.updateExperience(amount: experience)
        characterDatasource?.update(model: char)
    }
    
    func characterClassAt(index: Int) -> CharacterClass? {
        return Character.classes[index]
    }
    
    func characterClassStringAt(index: Int) -> String {
        return Character.classes[index].rawValue
    }
    
    func didUpdatePlayers(players: [Player]) {
        // unused but required delegate method
    }
}
