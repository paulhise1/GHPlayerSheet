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
    private(set) var scenario: Scenario
    var hosting: Bool
    
    
    var playerCount: Int {
        return players.count
    }
    
    init(party: String, character: Character, scenario: Scenario, hosting: Bool, service: ScenarioService) {
        self.party = party
        self.scenario = scenario
        self.hosting = hosting
        self.player = ScenarioPlayer(from: character)
        self.service = service
        self.service.delegate = self
        setupScenario()
        addPlayerToService()
    }
    
    func setupScenario() {
        guard hosting else { return }
        service.createScenario(party: self.party, number: scenario.number, difficulty: scenario.difficulty)
    }
    
    func addPlayerToService() {
        service.pushPlayerToService(player: player)
    }
    
    func updateCurrentHealth(value: String) {
        player.health = value
        service.pushPlayerToService(player: player)
    }
    
    func updateCurrentExperience(value: String) {
        player.experience = value
        service.pushPlayerToService(player: player)
    }
    
    func updateCurrentLoot(value: String) {
        player.loot = value
        service.pushPlayerToService(player: player)
    }
    
    func updateBattlemarkCount(_ count: String) {
        player.battlemarks = count
        service.pushPlayerToService(player: player)
    }

}

extension ScenarioViewModel: ScenarioServiceDelegate {
    func didUpdatePlayers(players: [ScenarioPlayer]) {
        self.players = players.filter{ $0 != self.player}
        delegate?.didUpdatePlayers()
    }
    
    func willCreateScenario(hostName: String) {
    }
    func didCreateScenario(_ scenario: Scenario) {
    }
    func resetCreateScenario() {
    }
}

