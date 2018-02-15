import Foundation

protocol ScenarioViewModelDelegate: class {
    func didUpdatePlayers()
}

class ScenarioViewModel {
    
    weak var delegate: ScenarioViewModelDelegate?
    
    private(set) var players = [ScenarioPlayer]()
    private var service: ScenarioService
    
    private(set) var player: ScenarioPlayer
    private(set) var party: String
    private(set) var scenario: Scenario?
    
    
    var playerCount: Int {
        return players.count
    }
    
    init(party: String, character: Character, scenario: Scenario?) {
        self.party = party
        self.scenario = scenario
        self.player = ScenarioPlayer(from: character)
        self.service = FirebaseService(party: party)
        self.service.delegate = self
        setupScenario()
        addPlayerToService()
    }
 
    func getScenario() {
        service.scenarioInfo()
    }
    
    func setupScenario() {
        guard let scenario = scenario, let difficulty = scenario.difficulty else { return }
        service.createScenario(party: self.party, number: scenario.number, difficulty: difficulty)
    }
    
    func addPlayerToService() {
        service.pushPlayerToService(player: player)
    }
    
//    func removePlayerFromSerivce() {
//        service.removePlayerFromService(player: player)
//    }
    
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
        delegate?.didUpdatePlayers()
    }

    func didGetScenarioNumber(_ scenarioNumber: String) {
        scenario = Scenario.scenarioFromNumber(scenarioNumber)
    }
    
    func willCreateScenario(hostName: String) {
    }
    func didCreateScenario(_ scenario: Scenario) {
    }
}

