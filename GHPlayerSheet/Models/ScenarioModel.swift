import Foundation

struct Scenario {
    
    let number: String
    let name: String
    let requirements: String
    let goal: String
    
    init(number: String, name: String, requirements: String, goal: String) {
        self.number = number
        self.name = name
        self.requirements = requirements
        self.goal = goal
    }
    
    private static func generateScenarios() -> [Scenario] {
        let scenario1 = Scenario(number: "1", name: "Black Barrow", requirements: "None", goal: "Kill all enemies")
        let scenario2 = Scenario(number: "2", name: "Barrow Lair", requirements: "First Steps (Party) COMPLETE", goal: "Kill the Bandit Commander and all revealed enemies")
        let scenario3 = Scenario(number: "3", name: "Inox Encampment", requirements: "The Merchant Flees (Global) INCOMPLETE", goal: "Kill a number of enemies to five times the number of characters")
        return [scenario1, scenario2, scenario3]
    }
    
    static func allScenarios() -> [Scenario] {
        return generateScenarios()
    }
    
    static func scenarioFromNumber(_ number: String) -> Scenario? {
        for scenario in Scenario.generateScenarios() {
            if scenario.number == number {
                return scenario
            }
        }
        return nil
    }
}
