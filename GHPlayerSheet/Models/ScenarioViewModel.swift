import Foundation

protocol ScenarioViewModelDelegate: class {
    func didUpdatePlayers()
}

class ScenarioViewModel {
    
    struct Constant {
        static let pathComponent = "ScenarioPlayer.plist"
    }
    
    enum ScenerioEndState {
        case success
        case failure
    }
    
    weak var delegate: ScenarioViewModelDelegate?
    
    private(set) var players = [ScenarioPlayer]()
    private var service: ScenarioService
    
    private(set) var player: ScenarioPlayer
    private(set) var party: String
    private(set) var scenario: Scenario
    private var scenarioEndState: ScenerioEndState?
    let hosting: Bool
    let scenarioPlayerDatasource: ModelDatasource<ScenarioPlayer>
    let character: Character
    
    var playerCount: Int {
        return players.count
    }
    
    init(party: String, character: Character, scenario: Scenario, hosting: Bool, service: ScenarioService) {
        self.party = party
        self.character = character
        self.scenario = scenario
        self.hosting = hosting
        self.player = ScenarioPlayer(from: character)
        let url = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.scenarioPlayerDatasource = ModelDatasource(with: url)
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
        scenarioPlayerDatasource.update(model: player)
    }
    
    func updateCurrentExperience(value: String) {
        player.experience = value
        service.pushPlayerToService(player: player)
        scenarioPlayerDatasource.update(model: player)
    }
    
    func updateCurrentLoot(value: String) {
        player.loot = value
        service.pushPlayerToService(player: player)
        scenarioPlayerDatasource.update(model: player)
    }
    
    func updateBattlemarkCount(_ count: String) {
        player.battlemarks = count
        service.pushPlayerToService(player: player)
        scenarioPlayerDatasource.update(model: player)
    }
    
    func endScenario(success: Bool) {
        service.completeScenario(success: success)
    }
    
    func scenarioOutcome() -> Bool? {
        if scenarioEndState == .success {
            return true
        } else if scenarioEndState == .failure {
            return false
        }
        return nil
    }
    
    func cleanupEndedScenario(gold: Int, experience: Int, battlemarks: Int) {
        addEarnedScenarioStatsToCharacter(gold: gold, experience: experience, battlemarks: battlemarks)
    }
    
    func addEarnedScenarioStatsToCharacter(gold: Int, experience: Int, battlemarks: Int) {
        self.character.updateGold(amount: gold)
        self.character.updateExperience(amount: experience)
        self.character.updateBattlemarks(amount: battlemarks)
        scenarioPlayerDatasource.remove(model: player)
    }
}

extension ScenarioViewModel: ScenarioServiceDelegate {
    func didRefreshPlayers(_ players: [ScenarioPlayer]) {
        self.players = players.filter{ $0 != self.player}
        delegate?.didUpdatePlayers()
    }
    
    func didEndScenario(success: Bool) {
        if success {
            scenarioEndState = .success
        } else {
            scenarioEndState = .failure
        }
    }
}

