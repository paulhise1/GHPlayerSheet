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
    let partyName = "The Funk Hunters"
    private(set) var scenarioService: ScenarioService
    private var characterDatasource: ModelDatasource<Character>?
    
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
        self.scenarioService = FirebaseService(partyName: partyName)
        self.scenarioService.delegate = self
        
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.characterDatasource = ModelDatasource(with: url)
    }
    
    func characterInfoForLabel() -> String {
        guard let char = character else { return "No character info available" }
        return "\(char.name): Level \(char.level) \(char.characterClass.rawValue)"
    }
    
    func startScenario(number: String) {
        scenarioService.createScenario(partyName: partyName, number: number)
    }
    
    func didGetScenarioNumber(scenarioNumber: String) {
        guard let scenarioName = Scenario.scenarioFromNumber(scenarioNumber)?.name else { return }
        let scenarioLableText = "# \(scenarioNumber): \(scenarioName)"
        delegate?.updateScenarioInfo(scenarioLabelText: scenarioLableText)
    }
    
    func createCharacter(charClass: CharacterClass, name: String, experience: Int) {
        character = Character(characterClass: charClass, name: name)
        character?.updateExperience(amount: experience)
    }
    
    func characterClassAt(index: Int) -> CharacterClass? {
        return Character.classes[index]
    }
    
    func characterClassAttributedStringAt(index: Int) -> NSAttributedString {
        return NSAttributedString(string: Character.classes[index].rawValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    func didUpdatePlayers(players: [Player]) {
        // just need this to conform to delegate so I can get the scenarioNumber Info
    }
}
