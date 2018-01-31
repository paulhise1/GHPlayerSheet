import Foundation
import FirebaseDatabase

class FirebaseService: ScenarioService {
    
    struct Constant {
        static let playerKey = "players"
        static let scenarioKey = "scenario"
        static let healthKey = "health"
        static let experienceKey = "experience"
        static let maxHealthKey = "maxHealth"
    }
    
    weak var delegate: ScenarioServiceDelegate?

    private let database: DatabaseReference
    
    let partyName: String
    
    init(partyName: String) {
        self.partyName = partyName
        database = Database.database().reference()
        configurePlayersListener()
        configureScenarioListener()
    }
    
    func createScenario(partyName: String, number: String) {
        database.child(partyName).setValue(Constant.playerKey)
        database.child(partyName).child(Constant.scenarioKey).setValue([Constant.scenarioKey: number])
    }
    
    func pushPlayerToService(player: Player) {
        let playerName = player.name
        let playerInfo = [Constant.healthKey: player.health, Constant.experienceKey: player.experience, Constant.maxHealthKey: player.maxHealth]
        database.child(partyName).child(Constant.playerKey).child(playerName).setValue(playerInfo)
    }
    
    func scenarioInfo() {
        configureScenarioListener()
    }
    
    private func configurePlayersListener(){
        let playerRef = database.child(partyName).child(Constant.playerKey)
        playerRef.observe(.value, with: { (snapshot) in
            self.processPlayers(snapshot: snapshot)
        })
    }
    
    private func configureScenarioListener() {
        let scenarioRef = database.child(partyName).child(Constant.scenarioKey)
        scenarioRef.observe(.value, with: { (snapshot) in
            self.processScenario(snapshot: snapshot)
        })
    }
    
    private func processPlayers(snapshot: DataSnapshot) {
        guard let playerDictFromFirebase = snapshot.value as? [String: [String: String]] else { return }
        var players = [Player]()
        for (player, stats) in playerDictFromFirebase {
            guard let health = stats[Constant.healthKey], let exp = stats[Constant.experienceKey], let maxHealth = stats[Constant.maxHealthKey] else { return }
            players.append(Player(name: player, experience: exp, health: health, maxHealth: maxHealth))
        }
        self.delegate?.didUpdatePlayers(players: players)
    }
    
    private func processScenario(snapshot: DataSnapshot) {
        guard let scenarioDict = snapshot.value as? [String: String], let scenario = scenarioDict[Constant.scenarioKey] else { return }
        self.delegate?.didGetScenarioNumber(scenarioNumber: scenario)
    }
}
