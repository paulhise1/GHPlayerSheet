import UIKit
import DynamicBlurView

enum StatType {
    case gold
    case experience
}

protocol StatModifierViewDelegate: class {
    func statModifierViewDidBeginModifying(sender: StatModifierView)
    func statModifierViewDidEndModifying(sender: StatModifierView)
    func didUpdateGold(amount: Int)
    func didUpdateExperience(amount: Int)
}


class StatModifierView: UIView {

    weak var delegate: StatModifierViewDelegate?
    
    var currentStatType: StatType?
    var goldAmount: Int? {
        didSet {
            if let gold = goldAmount {
            goldButton.setTitle("\(gold)", for: .normal)
            }
        }
    }
    var experienceAmount: Int? {
        didSet {
            if let experience = experienceAmount{
                experienceButton.setTitle("\(experience)", for: .normal)
            }
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
                delegate?.didUpdateGold(amount: amount)
            case .experience?:
                delegate?.didUpdateExperience(amount: amount)
            default:
                return
            }
        }
        dismissNumpad()
    }
    
    //Ask Tim about these unwrapping functions.  avoiding so many if lets but also set values to possibly unwanted values and not sure if that is any better than force unwrapping.  seems similar to nil coalessing with those values as the second part of them.
    @IBAction func acceptSubtractionButtonTapped(_ sender: Any) {
        
        let gold = unwrapOptionalInt(optionalInt: goldAmount)
        let experience = unwrapOptionalInt(optionalInt: experienceAmount)
        let enteredAmount = unwrapOptionalString(optionalString: amountLabel.text)
        let amountInt = unwrapOptionalInt(optionalInt: Int(enteredAmount))
        
        switch currentStatType {
        case .gold?:
            if amountInt <= gold {
                delegate?.didUpdateGold(amount: -(amountInt))
                dismissNumpad()
            }
        case .experience?:
            if amountInt <= experience {
                delegate?.didUpdateExperience(amount: -(amountInt))
                dismissNumpad()
            }
        default:
            return
        }
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

    func unwrapOptionalString(optionalString: String?) -> String {
        if let unwrappedString = optionalString {
            return unwrappedString
        }
        return ""
    }

    func unwrapOptionalInt(optionalInt: Int?) -> Int {
        if let unwrappedInt = optionalInt {
            return unwrappedInt
        }
        return 0
    }
    
    func widthForAlignment() -> CGFloat {
        return goldButton.frame.size.width
    }
    
    
    
}





