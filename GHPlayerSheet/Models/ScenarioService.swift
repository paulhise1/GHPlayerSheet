import Foundation

protocol ScenarioService {
    weak var delegate: ScenarioServiceDelegate? {get set}
    func pushPlayerToService(player: ScenarioPlayer)
    func createScenario(party: String, number: String, difficulty: String)
    func startScenarioCreation(party: String, playerName: String)
    func resetScenarioCreation(party: String)
    func completeScenario(success: Bool)
}

protocol ScenarioServiceDelegate: class {
    // This is for live game scenarios
    func didRefreshPlayers(_ players: [ScenarioPlayer])
    func didEndScenario(success: Bool) 
    
    // This is for controllers dealing with creation
    func willCreateScenario(hostName: String)
    func didCreateScenario(_ scenario: Scenario)
    func didCancelScenarioCreation()
    func activeScenarioNotLocated()
    func shouldListenForStatusChanges() -> Bool
}

// Default implementations make these behave as if they were optional
extension ScenarioServiceDelegate {
    func didRefreshPlayers(_ players: [ScenarioPlayer]) {}
    func didEndScenario(success: Bool) {}

    
    func willCreateScenario(hostName: String) {}
    func didCreateScenario(_ scenario: Scenario) {}
    func didCancelScenarioCreation() {}
    func activeScenarioNotLocated() {}
    func shouldListenForStatusChanges() -> Bool { return false }
}
