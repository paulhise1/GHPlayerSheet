import Foundation
import FirebaseDatabase

class FirebaseService: ScenarioService {
    
    enum ScenarioStatus: String {
        case creating = "creating"
        case active = "active"
    }
    
    typealias ScenarioIDString = String
    struct Constant {
        static let playerKey = "players"
        static let healthKey = "health"
        static let experienceKey = "experience"
        static let maxHealthKey = "maxHealth"
        static let lootKey = "loot"
        static let statusKey = "status"
        static let hostKey = "host"
        static let numberKey = "number"
        static let difficultyKey = "difficulty"
        static let battlemarksKey = "battlemarks"
        static let currentScenario = "currentScenario"
    }
    
    weak var delegate: ScenarioServiceDelegate?

    private let database: DatabaseReference
    
    private let party: String
    
    private var currentScenarioID: String?
    
    init(party: String) {
        self.party = party
        database = Database.database().reference()
        configureIDListener()
    }
    
    func setScenarioID(scenarioID: String) {
        self.currentScenarioID = scenarioID
        configureScenarioStatusListener()
    }
    
    func startScenarioCreation(party: String, playerName: String) {
        self.currentScenarioID = String(describing: Date())
        let scenarioCreatingDict = [Constant.statusKey: ScenarioStatus.creating.rawValue, Constant.hostKey: playerName]
        activeScenarioRef()?.setValue(scenarioCreatingDict)
    }
    
    func resetCreatingScenario(party: String) {
        activeScenarioRef()?.setValue(nil)
    }

    func createScenario(party: String, number: String, difficulty: String) {
        let scenarioValues = [Constant.statusKey: ScenarioStatus.active.rawValue, Constant.numberKey: number, Constant.difficultyKey: difficulty]
        activeScenarioRef()?.updateChildValues(scenarioValues)
        configureScenarioStatusListener()
    }
    
    func pushPlayerToService(player: ScenarioPlayer) {
        configurePlayersListener()
        let playerInfo = [Constant.healthKey: player.health, Constant.experienceKey: player.experience, Constant.maxHealthKey: player.maxHealth, Constant.lootKey: player.loot, Constant.battlemarksKey: player.battlemarks]
        playerNameRefForPlayer(player)?.setValue(playerInfo)
    }
    
    private func configureIDListener() {
        currentScenarioRef()?.observe(.value, with: { (snapshot) in
            guard let currentScenarioRoot = snapshot.value as? [String: [String: Any]], let currentScenarioProperties = currentScenarioRoot.values.first else { return }
            if currentScenarioProperties[Constant.statusKey] as? String == ScenarioStatus.creating.rawValue {
                self.currentScenarioID = currentScenarioRoot.keys.first
                self.configureScenarioStatusListener()
            }
        })
    }
    
    private func configurePlayersListener() {
        guard let scenarioID = currentScenarioID else { return }
        let playerRef = database.child(party).child(scenarioID).child(Constant.playerKey)
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
        
        self.delegate?.didRefreshPlayers(players)
    }
    
    private func configureScenarioStatusListener() {
        currentScenarioRef()?.observe(.value, with: { (snapshot) in
            guard let currentScenarioDict = snapshot.value as? [ScenarioIDString: [String: Any]] else {
                self.delegate?.didCancelScenarioCreation()
                return
            }
            guard let currentScenarioID = self.currentScenarioID else { return }
            guard let properties = currentScenarioDict[currentScenarioID] else { return }
            guard let statusString = properties[Constant.statusKey] as? String else { return }
            guard let status = FirebaseService.ScenarioStatus(rawValue: statusString) else { return }
            
            self.informDelegateUpdatedScenarioStatus(status, currentScenarioProperties: properties)
        })
    }
    
    private func informDelegateUpdatedScenarioStatus(_ status: ScenarioStatus, currentScenarioProperties: [String: Any]) {
        switch status {
        case .creating:
            informDelegateWillCreateScenario(properties: currentScenarioProperties)
        case .active:
            informDelegateDidCreateScenario(properties: currentScenarioProperties)
        }
    }
    
    private func informDelegateDidCreateScenario(properties: [String: Any]) {
        guard let number = properties[Constant.numberKey] as? String else { return }
        guard let difficulty = properties[Constant.difficultyKey] as? String else { return }
        guard let scenario = Scenario.scenarioFromNumber(number, difficulty: difficulty) else { return }
        
        self.delegate?.didCreateScenario(scenario)
    }
    
    private func informDelegateWillCreateScenario(properties: [String: Any]) {
        guard let host = properties[Constant.hostKey] as? String else { return }
        
        self.delegate?.willCreateScenario(hostName: host)
    }
    
    // Mark: Helpers
    
    private func playerNameRefForPlayer(_ player: ScenarioPlayer) -> DatabaseReference? {
        return playersRef()?.child(player.name)
    }
    
    private func currentScenarioRef() -> DatabaseReference? {
        return database.child(party).child(Constant.currentScenario)
    }
    
    private func activeScenarioRef() -> DatabaseReference? {
        guard let currentScenarioID = self.currentScenarioID else { return nil }
        return currentScenarioRef()?.child(currentScenarioID)
    }
    
    private func playersRef() -> DatabaseReference? {
        return activeScenarioRef()?.child(Constant.playerKey)
    }
    
    private func statusRef() -> DatabaseReference? {
        return activeScenarioRef()?.child(Constant.statusKey)
    }
    
    private func hostRef() -> DatabaseReference? {
        return activeScenarioRef()?.child(Constant.hostKey)
    }
    
    private func difficultyRef() -> DatabaseReference? {
        return activeScenarioRef()?.child(Constant.difficultyKey)
    }
    
    private func scenarioNumberRef() -> DatabaseReference? {
        return activeScenarioRef()?.child(Constant.numberKey)
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    var prettyPrint: String {
        return String(describing: self as AnyObject)
    }
}
