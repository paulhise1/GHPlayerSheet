import UIKit

enum StatType {
    case gold
    case experience
}

protocol StatModifierViewDelegate: class {
    func statModifierViewDidBeginModifying(sender: StatModifierView)
    func statModifierViewDidEndModifying(sender: StatModifierView)
    func updateGold(updateGoldAmount: Int)
    func updateExperience(updateExperienceAmount: Int)
}


class StatModifierView: UIView {

    weak var delegate: StatModifierViewDelegate?
    
    var currentStatType: StatType?
    var goldAmount = Int()
    var experienceAmount = Int()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        
    }
    
    
    @IBOutlet weak var  goldButton: UIButton!
    @IBOutlet weak var experienceButton: UIButton!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var acceptSubtractionButton: UIButton!
    @IBOutlet weak var acceptAdditionButton: UIButton!
    
    @IBOutlet weak var numpadContainerView: UIView! {
        didSet {
            numpadContainerView.isHidden = true
        }
    }
    @IBOutlet var numberButtons: [UIButton]!
    

    //MARK: - Gold and Experience Button Methods
    @IBAction func goldButtonTapped(_ sender: Any) {
        if numpadContainerView.isHidden {
            currentStatType = StatType.gold
            modifyStat()
        } else {
            dismissNumpad()
        }
    }
    
    @IBAction func experienceButtonTapped(_ sender: Any) {
        if numpadContainerView.isHidden {
            currentStatType = StatType.experience
            modifyStat()
        } else {
            dismissNumpad()
        }
    }
    
    func modifyStat() {
        delegate?.statModifierViewDidBeginModifying(sender: self)
        var buttonToShow = UIButton()
        var buttonToHide = UIButton()
        if currentStatType == .gold {
            buttonToShow = goldButton
            buttonToHide = experienceButton
        } else if currentStatType == .experience {
            buttonToShow = experienceButton
            buttonToHide = goldButton
        }
        numpadContainerView.isHidden = false
        bringSubview(toFront: numpadContainerView)
        bringSubview(toFront: buttonToShow)
        buttonToHide.isHidden = true
    }
    
    
    //MARK: - Number Pad Methods
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        var amount = amountLabel.text!
        if amount == "0" {
            amount = ""
        }
        amount = amount + sender.titleLabel!.text!
        amountLabel.text = amount
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        var amount = amountLabel.text!
        amount = String(amount.dropLast())
        if amount == "" {
            amount = "0"
        }
        amountLabel.text = amount
    }
    
    @IBAction func acceptAdditionButtonTapped(_ sender: Any) {
        if let inputAmount = Int(amountLabel.text!) {
            switch currentStatType {
            case .gold?:
                goldAmount = goldAmount + inputAmount
                delegate?.updateGold(updateGoldAmount: goldAmount)
            case .experience?:
                experienceAmount = experienceAmount + inputAmount
                delegate?.updateExperience(updateExperienceAmount: experienceAmount)
            default:
                return
            }
        }
        dismissNumpad()
    }
    
    @IBAction func acceptSubtractionButtonTapped(_ sender: Any) {
        if let inputAmount = Int(amountLabel.text!) {
            switch currentStatType {
            case .gold?:
                goldAmount = goldAmount - inputAmount
                delegate?.updateGold(updateGoldAmount: goldAmount)
            case .experience?:
                experienceAmount = experienceAmount - inputAmount
                delegate?.updateExperience(updateExperienceAmount: experienceAmount)
            default:
                return
            }
        }
        dismissNumpad()
    }

    
    //MARK: - Helper Methods
    func dismissNumpad() {
        amountLabel.text = "0"
        numpadContainerView.isHidden = true
        goldButton.isHidden = false
        experienceButton.isHidden = false
        goldButton.setTitle(String(goldAmount), for: .normal)
        experienceButton.setTitle(String(experienceAmount), for: .normal)
        delegate?.statModifierViewDidEndModifying(sender: self)
        
    }
    
    func widthForAlignment() -> CGFloat {
        return goldButton.frame.size.width
    }
    
    
    
}





