import UIKit
import DynamicBlurView

enum StatType {
    case gold
    case experience
}

protocol StatModifierViewDelegate: class {
    func statModifierViewDidBeginModifying(sender: StatModifierView)
    func statModifierViewDidEndModifying(sender: StatModifierView)
    func updateGold(amount: Int)
    func updateExperience(amount: Int)
}


class StatModifierView: UIView {

    weak var delegate: StatModifierViewDelegate?
    
    var currentStatType: StatType?
    
    var goldAmount: Int? {
        didSet {
            goldButton.setTitle("\(goldAmount!)", for: .normal)
        }
    }
    
    var experienceAmount: Int? {
        didSet {
            experienceButton.setTitle("\(experienceAmount!)", for: .normal)
        }
    }
    
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
    
    // create did sets for labels
    @IBOutlet weak var goldButton: UIButton!
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
        var buttonToFront: UIButton
        var buttonToDisable: UIButton
        if currentStatType == .gold {
            buttonToFront = goldButton
            buttonToDisable = experienceButton
        } else {
            buttonToFront = experienceButton
            buttonToDisable = goldButton
        }
        numpadContainerView.isHidden = false
        bringSubview(toFront: numpadContainerView)
        bringSubview(toFront: buttonToFront)
        buttonToDisable.isEnabled = false
        //sendSubview(toBack: buttonToDisable)
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
        if let amount = Int(amountLabel.text!) {
            switch currentStatType {
            case .gold?:
                delegate?.updateGold(amount: amount)
            case .experience?:
                delegate?.updateExperience(amount: amount)
            default:
                return
            }
        }
        dismissNumpad()
    }
    
    @IBAction func acceptSubtractionButtonTapped(_ sender: Any) {
        if let enteredAmount = Int(amountLabel.text!) {
            switch currentStatType {
            case .gold?:
                delegate?.updateGold(amount: -(enteredAmount))
            case .experience?:
                delegate?.updateExperience(amount: -(enteredAmount))
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
        bringSubview(toFront: goldButton)
        bringSubview(toFront: experienceButton)
        goldButton.isEnabled = true
        experienceButton.isEnabled = true
        delegate?.statModifierViewDidEndModifying(sender: self)
        
    }
    
    func widthForAlignment() -> CGFloat {
        return goldButton.frame.size.width
    }
    
    
    
}





