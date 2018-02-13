import Foundation

protocol ScenarioService {
    weak var delegate: ScenarioServiceDelegate? {get set}
    func pushPlayerToService(player: ScenarioPlayer)
    func createScenario(partyName: String, number: String)
    func addScenarioInfoListener()
    //func updatePartyName(partyName: String)
    func removePlayerFromService(player: ScenarioPlayer)
}

protocol ScenarioServiceDelegate: class {
    func didUpdatePlayers(players: [ScenarioPlayer])
    func didGetScenarioNumber(scenarioNumber: String)
}

struct ScenarioPlayer: Hashable, Equatable {
    var hashValue: Int {
        return name.hashValue
    }
    
    var name: String
    var experience = "0"
    var health: String
    var maxHealth: String
    
    init(from character: Character) {
        self.name = character.name
        self.health = String(character.health)
        self.maxHealth = String(character.health)
        self.health = String(character.health)
    }
    
    init(name: String, experience: String, health: String, maxHealth: String) {
        self.name = name
        self.experience = experience
        self.health = health
        self.maxHealth = maxHealth
    }
    
    static func ==(lhs: ScenarioPlayer, rhs: ScenarioPlayer) -> Bool {
        return lhs.name == rhs.name
    }
}

protocol ScenarioViewModelDelegate: class {
    func didUpdatePlayers(players: [ScenarioPlayer])
    func setupLabelsForScenario(name: String, goal: String)
}

class ScenarioViewModel {
    
    weak var delegate: ScenarioViewModelDelegate?
    
    private var players = [ScenarioPlayer]()
    private var service: ScenarioService
    
    private(set) var player: ScenarioPlayer
    private(set) var party: String
    let scenario: Scenario
    
    
    var playerCount: Int {
        return players.count
    }
    
    init(partyName: String, character: Character, scenario: Scenario, difficulty: Int) {
        self.party = partyName
        self.scenario = scenario
        self.player = ScenarioPlayer(from: character)
        self.service = FirebaseService.self as! ScenarioService
        self.service.delegate = self
        addPlayerToService()
    }
    
    func addPlayerToService() {
        service.pushPlayerToService(player: player)
        service.addScenarioInfoListener()
    }
    
    func removePlayerFromSerivce() {
        service.removePlayerFromService(player: player)
    }
    
    func updateCurrentHealth(value: String) {
        player.health = value
        service.pushPlayerToService(player: player)
    }
    
    func updateCurrentExperience(value: String) {
        player.experience = value
        service.pushPlayerToService(player: player)
    }
}

extension ScenarioViewModel: ScenarioServiceDelegate {
    func didUpdatePlayers(players: [ScenarioPlayer]) {
        self.players = players.filter{ $0 != self.player}
        delegate?.didUpdatePlayers(players: self.players)
    }

    func didGetScenarioNumber(scenarioNumber: String) {
        guard let scenario = Scenario.scenarioFromNumber(scenarioNumber) else { return }
        let name = "Scenario # \(scenarioNumber): \(scenario.name)"
        let goal = "Goal: \(scenario.goal)"
        delegate?.setupLabelsForScenario(name: name, goal: goal)
    }
}

