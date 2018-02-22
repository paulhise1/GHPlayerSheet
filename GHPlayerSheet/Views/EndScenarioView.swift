import UIKit

protocol EndScenarioViewDelegate: class {
    func didEndScenario()
}

class EndScenarioView: UIView {
    
    struct Constant {
        static let successTitle = "Congatulations! You have earned:"
        static let failureTitle = "You have earned:"
        static let backgroundImage = "canvasBackground"
        static let checkedBox = "checkedBox"
        static let emptyBox = "emptyBox"
        static let noBattlemarksLabel = "no battlemarks recorded"
        static let oneBattlemarkLabel = "one battlemark recorded"
        static let twoBattlemarksLabel = "two battlemarks recorded"
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
    @IBOutlet weak var battlemarkStack: UIStackView!
    @IBOutlet weak var battlemarksEarnedLabel: UILabel!
    @IBOutlet weak var battlemarkLeftButton: UIButton!
    @IBOutlet weak var battlemarkRightButton: UIButton!
    weak var delegate: EndScenarioViewDelegate?
    
    private var victory: Bool?
    private var lootCount: String?
    private var experienceCount: String?
    private var difficulty: String?
    private var battlemarks: String?
    
    func configure(lootCount: String, experienceCount: String, difficulty: String, battlemarks: String) {
        resultButtonContainer.isHidden = true
        conclusionContainer.isHidden = true
        self.lootCount = lootCount
        self.experienceCount = experienceCount
        self.difficulty = difficulty
        self.backgroundView.image = UIImage(named: Constant.backgroundImage)
        self.battlemarks = battlemarks
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
    
    @IBAction func battlemarkLeftButtonTapped(_ sender: Any) {
        if battlemarks == "0" {
            battlemarks = "1"
            battlemarkLeftButton.setImage(UIImage(named: Constant.checkedBox), for: .normal)
            battlemarkRightButton.isEnabled = true
            battlemarksEarnedLabel.text = Constant.oneBattlemarkLabel
        } else if battlemarks == "1" {
            battlemarks = "0"
            battlemarkLeftButton.setImage(UIImage(named: Constant.emptyBox), for: .normal)
            battlemarkRightButton.isEnabled = false
            battlemarksEarnedLabel.text = Constant.noBattlemarksLabel
        }
    }
    
    @IBAction func battlemarkRightButtonTapped(_ sender: Any) {
        if battlemarks == "1" {
            battlemarks = "2"
            battlemarkRightButton.setImage(UIImage(named: Constant.checkedBox), for: .normal)
            battlemarkLeftButton.isEnabled = false
            battlemarksEarnedLabel.text = Constant.twoBattlemarksLabel
        } else if battlemarks == "2" {
            battlemarks = "1"
            battlemarkRightButton.setImage(UIImage(named: Constant.emptyBox), for: .normal)
            battlemarkLeftButton.isEnabled = true
            battlemarksEarnedLabel.text = Constant.oneBattlemarkLabel
        }
    }
    
    @IBAction func recordStatsButtonTapped(_ sender: Any) {
        delegate?.didEndScenario()
    }
    
    private func successConclusion() {
        conclusionTitleLabel.text = Constant.successTitle
        statsFromScenario()
        guard let difficulty = difficulty, let difficultyInt = Int(difficulty) else { return }
        let bonusExperience = 4 + 2 * difficultyInt
        bonusExperienceNumberLabel.text = String(bonusExperience)
        if battlemarks == "1" {
            battlemarkLeftButton.setImage(UIImage(named: Constant.checkedBox), for: .normal)
            battlemarkRightButton.isEnabled = true
            battlemarksEarnedLabel.text = Constant.oneBattlemarkLabel
        } else if battlemarks == "2" {
            battlemarkLeftButton.setImage(UIImage(named: Constant.checkedBox), for: .normal)
            battlemarkRightButton.setImage(UIImage(named: Constant.checkedBox), for: .normal)
            battlemarkLeftButton.isEnabled = false
            battlemarksEarnedLabel.text = Constant.twoBattlemarksLabel
        }
    }
    
    private func failureConclusion() {
        conclusionTitleLabel.text = Constant.failureTitle
        statsFromScenario()
        bonusExperienceStack.isHidden = true
        battlemarkStack.isHidden = true
    }
    
    private func statsFromScenario() {
        guard let lootCount = lootCount, let intLootCount = Int(lootCount), let difficulty = difficulty, let difficultyInt = Int(difficulty) else { return }
        let goldFromLoot = intLootCount * difficultyInt
        lootNumberLabel.text = lootCount
        lootEarnedLabel.text = "converts to \(goldFromLoot) gold"
        experienceNumberLabel.text = experienceCount
        difficultyLevelLabel.text = difficulty
    }
}
