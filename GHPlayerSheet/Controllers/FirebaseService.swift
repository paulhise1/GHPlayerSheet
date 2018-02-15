import Foundation
import FirebaseDatabase

class FirebaseService: ScenarioService {
    
    enum ScenarioStatus: String {
        case creating = "creating"
        case active = "active"
    }
    
    struct Constant {
        static let playerKey = "players"
        static let scenarioKey = "scenario"
        static let healthKey = "health"
        static let experienceKey = "experience"
        static let maxHealthKey = "maxHealth"
        static let statusKey = "status"
        static let hostKey = "host"
        static let numberKey = "number"
        static let difficultyKey = "difficulty"
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
    
    func startScenarioCreation(party: String, playerName: String) {
        database.child(party).child(Constant.scenarioKey).setValue([Constant.statusKey: ScenarioStatus.creating.rawValue, Constant.hostKey: playerName])
    }
    
    func createScenario(party: String, number: String, difficulty: String) {
        database.child(party).child(Constant.scenarioKey).updateChildValues([Constant.statusKey: ScenarioStatus.active.rawValue, Constant.numberKey: number, Constant.difficultyKey: difficulty])
    }
    
    func pushPlayerToService(player: ScenarioPlayer) {
        configurePlayersListener()
        let playerName = player.name
        let playerInfo = [Constant.healthKey: player.health, Constant.experienceKey: player.experience, Constant.maxHealthKey: player.maxHealth]
        database.child(party).child(Constant.scenarioKey).child(Constant.playerKey).child(playerName).setValue(playerInfo)
    }
    
    func scenarioInfo() {
        configureScenarioStatusListener()
    }
    
    func updatePartyName(partyName: String) {
        self.party = partyName
        configurePlayersListener()
    }
    
//    func removePlayerFromService(player: ScenarioPlayer) {
//        guard let party = partyName else { return }
//        database.child(party).child(Constant.playerKey).child(player.name).removeValue()
//        addScenarioInfoListener()
//    }
    
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
            guard let health = stats[Constant.healthKey], let exp = stats[Constant.experienceKey], let maxHealth = stats[Constant.maxHealthKey] else { return }
            players.append(ScenarioPlayer(name: player, experience: exp, health: health, maxHealth: maxHealth))
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
            // Need hostname
            delegate?.willCreateScenario(hostName: "Host")
        case .active:
            // Need scenario number to reconstruct scenario model
            delegate?.didCreateScenario(Scenario.scenarioFromNumber("11")!)
            delegate?.didGetScenarioNumber("11")
        }
    }
}
