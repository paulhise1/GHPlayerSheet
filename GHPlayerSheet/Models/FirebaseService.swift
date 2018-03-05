import Foundation
import FirebaseDatabase

class FirebaseService: ScenarioService {
    
    enum ScenarioStatus: String {
        case creating = "creating"
        case active = "active"
        case completed = "completed"
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
        static let successKey = "success"
        static let battlemarksKey = "battlemarks"
    }
    
    weak var delegate: ScenarioServiceDelegate? {
        didSet{
            guard let delegate = self.delegate else { return }
            if delegate.shouldListenForStatusChanges() {
                beginListeningToScenarioStatus()
            }
        }
    }

    private let database: DatabaseReference
    
    private let party: String
    
    private var activeScenarioID: String? 
    
    init(party: String) {
        self.party = party
        database = Database.database().reference()
    }
    
    func startScenarioCreation(party: String, playerName: String) {
        self.activeScenarioID = String(describing: Date())
        let scenarioCreatingDict = [Constant.statusKey: ScenarioStatus.creating.rawValue, Constant.hostKey: playerName]
        activeScenarioRef()?.setValue(scenarioCreatingDict)
    }
    
    func completeScenario(success: Bool) {
        successRef()?.setValue(success)
        statusRef()?.setValue(ScenarioStatus.completed.rawValue)
        activeScenarioID = nil
    }
    
    func resetScenarioCreation(party: String) {
        clearActiveScenario()
    }

    func createScenario(party: String, number: String, difficulty: String) {
        let scenarioValues = [Constant.statusKey: ScenarioStatus.active.rawValue, Constant.numberKey: number, Constant.difficultyKey: difficulty]
        activeScenarioRef()?.updateChildValues(scenarioValues)
        beginListeningToScenarioStatus()
    }
    
    func pushPlayerToService(player: ScenarioPlayer) {
        removePartyRefListeners()
        configurePlayersListener()
        let playerInfo = [Constant.healthKey: player.health, Constant.experienceKey: player.experience, Constant.maxHealthKey: player.maxHealth, Constant.lootKey: player.loot, Constant.battlemarksKey: player.battlemarks]
        playerNameRefForPlayer(player)?.setValue(playerInfo)
    }
    
    private func beginListeningToScenarioStatus() {
        ensureActiveScenarioExists()
        activeScenarioRef()?.observe(.value, with: { (snapshot) in
            guard let activeScenarioProperties = snapshot.value as? [String: Any] else {
                self.delegate?.didCancelScenarioCreation()
                return
            }
            if let successOutcome = activeScenarioProperties[Constant.successKey] as? Bool {
                self.delegate?.didEndScenario(success: successOutcome)
                return
            }
            guard let statusString = activeScenarioProperties[Constant.statusKey] as? String else { return }
            guard let status = FirebaseService.ScenarioStatus(rawValue: statusString) else { return }
            
            self.informDelegateUpdatedScenarioStatus(status, activeScenarioProperties: activeScenarioProperties)
        })
    }
    
    private func ensureActiveScenarioExists() {
        if activeScenarioRef() == nil {
            partyRef().observe(.value, with: { (snapshot) in
                guard let partyDict = snapshot.value as? [String: [String: Any]] else { return }
                guard self.partyHasActiveScenario(partyDict) else {
                    self.delegate?.activeScenarioNotLocated()
                    return
                }
            })
        }
    }
    
    private func informDelegateUpdatedScenarioStatus(_ status: ScenarioStatus, activeScenarioProperties: [String: Any]) {
        switch status {
        case .creating:
            informDelegateWillCreateScenario(properties: activeScenarioProperties)
        case .active:
            informDelegateDidCreateScenario(properties: activeScenarioProperties)
        case .completed:
            return
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
    
    private func configurePlayersListener() {
        guard let scenarioID = activeScenarioID else { return }
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
    
    // Mark: Helpers
    
    private func partyHasActiveScenario(_ partyDict: [String : [String : Any]]) -> Bool {
        for (scenario, properties) in partyDict {
            if properties[Constant.statusKey] as? String != ScenarioStatus.completed.rawValue {
                self.activeScenarioID = scenario
                self.beginListeningToScenarioStatus()
                return true
            }
        }
        return false
    }
    
    private func playerNameRefForPlayer(_ player: ScenarioPlayer) -> DatabaseReference? {
        return playersRef()?.child(player.name)
    }
    
    private func partyRef() -> DatabaseReference {
        return database.child(party)
    }
    
    private func activeScenarioRef() -> DatabaseReference? {
        guard let activeScenarioID = self.activeScenarioID else { return nil }
        return partyRef().child(activeScenarioID)
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
    
    private func successRef() -> DatabaseReference? {
        return activeScenarioRef()?.child(Constant.successKey)
    }
    
    private func scenarioNumberRef() -> DatabaseReference? {
        return activeScenarioRef()?.child(Constant.numberKey)
    }
    
    private func clearActiveScenario() {
        activeScenarioRef()?.setValue(nil)
    }
    
    private func removePartyRefListeners() {
        partyRef().removeAllObservers()
    }
}
