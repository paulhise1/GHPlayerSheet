import Foundation
import FirebaseDatabase

class FirebaseService: ScenarioService {
    
    enum ScenarioStatus: String {
        case creating = "creating"
        case active = "active"
        case reset = "reset"
    }
    
    struct Constant {
        static let playerKey = "players"
        static let scenarioKey = "scenario"
        static let healthKey = "health"
        static let experienceKey = "experience"
        static let maxHealthKey = "maxHealth"
        static let lootKey = "loot"
        static let statusKey = "status"
        static let hostKey = "host"
        static let numberKey = "number"
        static let difficultyKey = "difficulty"
        static let battlemarksKey = "battlemarks"
    }
    
    weak var delegate: ScenarioServiceDelegate?

    private let database: DatabaseReference

    private(set) var party: String
    
    init(party: String) {
        self.party = party
        database = Database.database().reference()
        configurePlayersListener()
        configureScenarioStatusListener()
    }
    
    func scenarioStatus() {
        
    }
    
    func startScenarioCreation(party: String, playerName: String) {
        database.child(party).child(Constant.scenarioKey).setValue([Constant.statusKey: ScenarioStatus.creating.rawValue, Constant.hostKey: playerName])
    }
    
    func resetScenario(party: String) {
        database.child(party).child(Constant.scenarioKey).setValue([Constant.statusKey: ScenarioStatus.reset.rawValue, Constant.hostKey: nil])
    }

    func createScenario(party: String, number: String, difficulty: String) {
        database.child(party).child(Constant.scenarioKey).updateChildValues([Constant.statusKey: ScenarioStatus.active.rawValue, Constant.numberKey: number, Constant.difficultyKey: difficulty])
    }
    
    func pushPlayerToService(player: ScenarioPlayer) {
        configurePlayersListener()
        let playerName = player.name
        let playerInfo = [Constant.healthKey: player.health, Constant.experienceKey: player.experience, Constant.maxHealthKey: player.maxHealth, Constant.lootKey: player.loot, Constant.battlemarksKey: player.battlemarks]
        database.child(party).child(Constant.scenarioKey).child(Constant.playerKey).child(playerName).setValue(playerInfo)
    }
    
    private func configurePlayersListener(){
        let playerRef = database.child(party).child(Constant.scenarioKey).child(Constant.playerKey)
        playerRef.observe(.value, with: { (snapshot) in
            self.processPlayers(snapshot: snapshot)
        })
    }
    
    private func processPlayers(snapshot: DataSnapshot) {
        guard let playerDictFromFirebase = snapshot.value as? [String: [String: String]] else { return }
        var players = [ScenarioPlayer]()
        for (player, stats) in playerDictFromFirebase {
            guard let health = stats[Constant.healthKey], let exp = stats[Constant.experienceKey], let maxHealth = stats[Constant.maxHealthKey], let loot = stats[Constant.lootKey] else { return }
            players.append(ScenarioPlayer(name: player, experience: exp, health: health, maxHealth: maxHealth, loot: loot))
        }
        self.delegate?.didUpdatePlayers(players: players)
    }
    
    private func configureScenarioStatusListener() {
        let scenarioRef = database.child(party).child(Constant.scenarioKey).child(Constant.statusKey)
        scenarioRef.observe(.value, with: { (snapshot) in
            self.processScenario(snapshot: snapshot)
        })
    }

    private func processScenario(snapshot: DataSnapshot) {
        guard let statusString = snapshot.value as? String, let status = FirebaseService.ScenarioStatus(rawValue: statusString) else { return }
        switch status {
        case .creating:
            let hostRef = database.child(party).child(Constant.scenarioKey).child(Constant.hostKey)
            hostRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let host = snapshot.value as? String else { return }
                self.delegate?.willCreateScenario(hostName: host)
            })
        case .active:
            let scenarioNumberRef = database.child(party).child(Constant.scenarioKey).child(Constant.numberKey)
            let scenarioDifficultyRef = database.child(party).child(Constant.scenarioKey).child(Constant.difficultyKey)
            scenarioDifficultyRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let difficulty = snapshot.value as? String else { return }
                scenarioNumberRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let scenarioNumber = snapshot.value as? String, var scenario = Scenario.scenarioFromNumber(scenarioNumber) else { return }
                    scenario.difficulty = difficulty
                    self.delegate?.didCreateScenario(scenario)
                })
            })
        case .reset:
            delegate?.resetCreateScenario()
        }
    }
}
