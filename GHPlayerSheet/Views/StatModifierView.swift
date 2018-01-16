import UIKit

enum StatType {
    case gold
    case experience
}

class StatModifierView: UIView {

    var currentStatType: StatType?
    
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
    @IBOutlet weak var goldButtonLabel: UILabel!
    @IBOutlet weak var experienceButton: UIButton!
    @IBOutlet weak var experienceButtonLabel: UILabel!
    
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
    

    @IBAction func goldButtonTapped(_ sender: Any) {
        if numpadContainerView.isHidden {
            modifyGold()
        } else {
            switch currentStatType {
            case .gold?:
                numpadContainerView.isHidden = true
            default:
                modifyGold()
            }
        }
    }
    
    func modifyGold() {
        currentStatType = StatType.gold
        numpadContainerView.isHidden = false
        bringSubview(toFront: numpadContainerView)
        bringSubview(toFront: goldButton)
        bringSubview(toFront: goldButtonLabel)
    }
    
    @IBAction func experienceButtonTapped(_ sender: Any) {
        if numpadContainerView.isHidden {
            modifyExperience()
        } else {
            switch currentStatType {
            case .experience?:
                numpadContainerView.isHidden = true
            default:
                modifyExperience()
            }
        }
    }
    
    func modifyExperience() {
        currentStatType = StatType.experience
        numpadContainerView.isHidden = false
        bringSubview(toFront: numpadContainerView)
        bringSubview(toFront: experienceButton)
        bringSubview(toFront: experienceButtonLabel)
    }
    
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
                if let previousAmount = Int((goldButtonLabel.text)!) {
                    let amount = String(previousAmount + inputAmount)
                    goldButtonLabel.text = amount
                }
            case .experience?:
                if let previousAmount = Int((experienceButtonLabel.text)!) {
                    let amount = String(previousAmount + inputAmount)
                    experienceButtonLabel.text = amount
                }
            default:
                return
            }
        }
        resetNumPad()
    }
    
    @IBAction func acceptSubtractionButtonTapped(_ sender: Any) {
        if let inputAmount = Int(amountLabel.text!) {
            switch currentStatType {
            case .gold?:
                if let previousAmount = Int((goldButtonLabel.text)!) {
                    let amount = String(previousAmount - inputAmount)
                    goldButtonLabel.text = amount
                }
            case .experience?:
                if let previousAmount = Int((experienceButtonLabel.text)!) {
                    let amount = String(previousAmount - inputAmount)
                    experienceButtonLabel.text = amount
                }
            default:
                return
            }
        }
        resetNumPad()
    }
    
    func widthForAlignment() -> CGFloat {
        return goldButton.frame.size.width
    }

    //MARK: - Helper
    func resetNumPad() {
        amountLabel.text = "0"
        numpadContainerView.isHidden = true
    }
}
