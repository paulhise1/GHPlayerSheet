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
    private var firebaseService: FirebaseService
    
    weak var delegate: ScenarioViewModelDelegate?
    
    private(set) var name: String
    private(set) var maxHealth: String
    private(set) var currentHealth: String
    private(set) var currentExperience = "0"
    private var player: Player
    
    var playerCount: Int {
        return players.count
    }
    
    init(name: String, maxHealth: String, service: ScenarioService) {
        // This may not be the values we really want on init
        self.name = name
        self.maxHealth = maxHealth
        self.currentHealth = maxHealth
        self.service = service
        self.player = Player(name: name, experience: currentExperience, health: currentHealth, maxHealth: maxHealth)
        self.firebaseService = FirebaseService()
        self.firebaseService.delegate = self
        addPlayerToService()
    }
    
    func addPlayerToService() {
        service.pushPlayerToService(player: player)
    }
    
    func updateCurrentHealth(value: String) {
        currentHealth = value
        let player = Player(name: name, experience: currentExperience, health: currentHealth, maxHealth: maxHealth)
        service.pushPlayerToService(player: player)
    }
    
    
    func updateCurrentExperience(value: String) {
        currentExperience = value
        let player = Player(name: name, experience: currentExperience, health: currentHealth, maxHealth: maxHealth)
        service.pushPlayerToService(player: player)
    }
    
}

extension ScenarioViewModel: ScenarioServiceDelegate {
    
    func didUpdatePlayers(players: [Player]) {
        self.players = players.filter{ $0 != self.player}
        delegate?.didUpdatePlayers(players: self.players)
        print("$$$$$$ players from ViewModel: \(self.players) $$$$$$$")
    }
    
}

