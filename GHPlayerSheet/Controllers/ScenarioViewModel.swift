import Foundation

protocol ScenarioService {
    func pushPlayerToService(player: Player)
}

protocol ScenarioServiceDelegate: class {
    func didUpdatePlayers(players: [Player])
}

struct Player: Hashable, Equatable {
    var hashValue: Int {
        return name.hashValue
    }
    var name: String
    var experience: String
    var health: String
    var maxHealth: String
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}

protocol ScenarioViewModelDelegate: class {
    func didUpdatePlayers(players: [Player])
}

class ScenarioViewModel {
    private var players = [Player]()
    private var service: ScenarioService
    
    weak var delegate: ScenarioViewModelDelegate?
    
    private(set) var name: String
    private(set) var maxHealth: String
    private(set) var currentHealth: String
    private(set) var currentExperience = "0"
    var playerCount: Int {
        return players.count
    }
    
    init(name: String, maxHealth: String, service: ScenarioService) {
        // This may not be the values we really want on init
        self.name = name
        self.maxHealth = maxHealth
        self.currentHealth = maxHealth
        self.service = service
    }
    
    func updateCurrentHealth(value: String) {
        // counter changed so we need to tell firebase
    }
    
    func updateCurrentExperience(value: String) {
        // counter changed so we need to tell firebase
    }
}

extension ScenarioViewModel: ScenarioServiceDelegate {
    func didUpdatePlayers(players: [Player]) {
        
    }
}

