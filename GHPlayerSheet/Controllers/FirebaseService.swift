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
    
    private(set) var party: String
    
    init(party: String) {
        self.party = party
        database = Database.database().reference()
        configurePlayersListener()
        configureScenarioListener()
    }
    
    func createScenario(party: String, number: String, difficulty: String) {
        database.child(party).child(Constant.scenarioKey).setValue(["number": number, "difficulty": difficulty])
    }
    
    func pushPlayerToService(player: ScenarioPlayer) {
        configurePlayersListener()
        let playerName = player.name
        let playerInfo = [Constant.healthKey: player.health, Constant.experienceKey: player.experience, Constant.maxHealthKey: player.maxHealth]
        //        guard let party = party else { return }
        database.child(party).child(Constant.playerKey).child(playerName).setValue(playerInfo)
    }
    
    func updatePartyName(partyName: String) {
        self.party = partyName
        addScenarioInfoListener()
        configurePlayersListener()
    }
    
//    func removePlayerFromService(player: ScenarioPlayer) {
//        guard let party = partyName else { return }
//        database.child(party).child(Constant.playerKey).child(player.name).removeValue()
//        addScenarioInfoListener()
//    }
    
    func addScenarioInfoListener() {
        configureScenarioListener()
    }
    
    private func configurePlayersListener(){
//        guard let party = party else { return }
        let playerRef = database.child(party).child(Constant.playerKey)
        playerRef.observe(.value, with: { (snapshot) in
            self.processPlayers(snapshot: snapshot)
        })
    }
    
    private func configureScenarioListener() {
//        guard let party = party else { return }
        let scenarioRef = database.child(party).child(Constant.scenarioKey)
        scenarioRef.observe(.value, with: { (snapshot) in
            self.processScenario(snapshot: snapshot)
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
    
    
    private func processScenario(snapshot: DataSnapshot) {
        guard let number = snapshot.value as? String else { return }
        self.delegate?.didGetScenarioNumber(scenarioNumber: number)
    }
}
