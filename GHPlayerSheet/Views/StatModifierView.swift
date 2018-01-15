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
        print("did load")
    }
    
    func commonInit(){
        
    }
    
    @IBOutlet weak var goldButton: UIButton!
    @IBOutlet weak var experienceButton: UIButton!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var acceptSubtractionButton: UIButton!
    @IBOutlet weak var acceptAdditionButton: UIButton!
    
    @IBOutlet var numberButtons: [UIButton]!
    
    
    @IBAction func goldButtonTapped(_ sender: Any) {
        currentStatType = StatType.gold
    }
    
    @IBAction func experienceButtonTapped(_ sender: Any) {
        currentStatType = StatType.experience
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
                if let previousAmount = Int((goldButton.titleLabel?.text)!) {
                    let amount = String(previousAmount + inputAmount)
                    goldButton.setTitle(amount, for: .normal)
                }
            case .experience?:
                if let previousAmount = Int((experienceButton.titleLabel?.text)!) {
                    let amount = String(previousAmount + inputAmount)
                    experienceButton.setTitle(amount, for: .normal)
                }
            default:
                return
            }
        }
    }
    
    @IBAction func acceptSubtractionButtonTapped(_ sender: Any) {
        if let inputAmount = Int(amountLabel.text!) {
            switch currentStatType {
            case .gold?:
                if let previousAmount = Int((goldButton.titleLabel?.text)!) {
                    let amount = String(previousAmount - inputAmount)
                    goldButton.setTitle(amount, for: .normal)
                }
            case .experience?:
                if let previousAmount = Int((experienceButton.titleLabel?.text)!) {
                    let amount = String(previousAmount - inputAmount)
                    experienceButton.setTitle(amount, for: .normal)
                }
            default:
                return
            }
        }
    }

}
