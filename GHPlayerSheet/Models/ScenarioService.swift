import Foundation

protocol ScenarioService {
    weak var delegate: ScenarioServiceDelegate? {get set}
    func pushPlayerToService(player: ScenarioPlayer)
    func createScenario(party: String, number: String, difficulty: String)
    func startScenarioCreation(party: String, playerName: String)
    func resetScenario(party: String)
//    func scenarioInfo()
    //    func removePlayerFromService(player: ScenarioPlayer)
}

protocol ScenarioServiceDelegate: class {
    func didUpdatePlayers(players: [ScenarioPlayer])
    //func didGetScenarioNumber(_ scenarioNumber: String)
    func willCreateScenario(hostName: String)
    func didCreateScenario(_ scenario: Scenario)
    func resetCreateScenario()
}
