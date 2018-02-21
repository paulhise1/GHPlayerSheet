import UIKit

class EndScenarioView: UIView {
    
    struct Constant {
        static let successTitle = "Congatulations! You have earned:"
        static let failureTitle = "You have earned:"
        static let backgroundImage = "canvasBackground"
    }
    
    @IBOutlet weak var endScenarioButton: UIButton!
    @IBOutlet weak var resultButtonContainer: UIView!
    
    @IBOutlet weak var conclusionContainer: UIView!
    @IBOutlet weak var conclusionTitleLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!
    @IBOutlet weak var lootNumberLabel: UILabel!
    @IBOutlet weak var lootEarnedLabel: UILabel!
    @IBOutlet weak var experienceNumberLabel: UILabel!
    @IBOutlet weak var bonusExperienceNumberLabel: UILabel!
    @IBOutlet weak var bonusExperienceStack: UIStackView!
    @IBOutlet weak var backgroundView: UIImageView!
    
    private var victory: Bool?
    private var lootCount: String?
    private var experienceCount: String?
    private var difficulty: String?
    
    func configure(lootCount: String, experienceCount: String, difficulty: String) {
        resultButtonContainer.isHidden = true
        conclusionContainer.isHidden = true
        self.lootCount = lootCount
        self.experienceCount = experienceCount
        self.difficulty = difficulty
        self.backgroundView.image = UIImage(named: Constant.backgroundImage)
    }
    
    @IBAction func endButtonTapped(_ sender: Any) {
        endScenarioButton.isHidden = true
        resultButtonContainer.isHidden = false
    }
    
    @IBAction func failureButtonTapped(_ sender: Any) {
        victory = false
        showConclusion()
    }
    
    @IBAction func successButtonTapped(_ sender: Any) {
        victory = true
        showConclusion()
    }
    
    private func showConclusion() {
        resultButtonContainer.isHidden = true
        conclusionContainer.isHidden = false
        guard let victory = victory else { return }
        if victory {
            successConclusion()
        } else {
            failureConclusion()
        }
    }
    
    @IBAction func recordStatsButtonTapped(_ sender: Any) {
        
    }
    
    private func successConclusion() {
        conclusionTitleLabel.text = Constant.successTitle
        statsFromScenario()
        guard let difficulty = difficulty, let difficultyInt = Int(difficulty) else { return }
        let bonusExperience = 4 + 2 * difficultyInt
        bonusExperienceNumberLabel.text = String(bonusExperience)
    }
    
    private func failureConclusion() {
        conclusionTitleLabel.text = Constant.failureTitle
        statsFromScenario()
        bonusExperienceStack.isHidden = true
    }
    
    private func statsFromScenario() {
        guard let lootCount = lootCount, let intLootCount = Int(lootCount), let difficulty = difficulty, let difficultyInt = Int(difficulty) else { return }
        let goldFromLoot = intLootCount * difficultyInt
        lootNumberLabel.text = lootCount + " X "
        lootEarnedLabel.text = "converts to \(goldFromLoot) gold"
        experienceNumberLabel.text = experienceCount
        difficultyLevelLabel.text = difficulty
    }
}
