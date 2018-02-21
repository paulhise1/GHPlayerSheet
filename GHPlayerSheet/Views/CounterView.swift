import UIKit
import ChameleonFramework

enum CounterType {
    case generic
    case health
    case experience
    case loot
}

protocol CounterViewDelegate: class {
    func counterValueDidChange(value: String, type: CounterType)
}

class CounterView: UIView {

    weak var delegate: CounterViewDelegate?
    
    private var counterType: CounterType?
    private var value: Int?
    private var maxValue: Int?
    
    @IBOutlet private weak var decrementButton: UIButton!
    @IBOutlet private weak var incrementButton: UIButton!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 14
            backgroundView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var maxHealthLabel: UILabel!
    @IBOutlet weak var counterSymbolImageView: UIImageView!
    @IBOutlet weak var counterSymbolBackgroundImageView: UIImageView!
    
    func configure(value: String = "0", counterType: CounterType = .generic, maxValue: String? = nil) {
        self.value = Int(value)
        self.counterType = counterType
        setDefaultCounterSettings()
        counterLabel.text = String(value)
        counterLabel.font = FontConstants.counterNumberFont
        if let maxValue = maxValue {
            self.maxValue = Int(maxValue)
            self.maxHealthLabel.text = maxValue
            self.maxHealthLabel.textColor = ColorConstants.maxHealthLabelColor
            self.maxHealthLabel.font = FontConstants.counterMaxNumberFont
        }
    }
    
    @IBAction func incrementButtonTapped(_ sender: Any) {
        incrementCounter()
    }
    
    @IBAction func decrementButtonTapped(_ sender: Any) {
        decrementCounter()
    }
    
    private func setCounterValue(value: Int) {
        self.value = value
        counterLabel.text = String(value)
    }
    
    private func incrementCounter() {
        guard var newValue = value, let counterType = counterType else { return }
        if let maxValue = maxValue {
            newValue = min(newValue + 1, maxValue)
        } else {
            newValue = newValue + 1
        }
        setCounterValue(value: newValue)
        delegate?.counterValueDidChange(value: String(newValue), type: counterType)
        value = newValue
        if maxValue == newValue && counterType == .health {
            maxHealthLabel.isHidden = true
            counterLabel.textColor = ColorConstants.maxHealthLabelColor
        }
    }
    
    private func decrementCounter() {
        guard var newValue = value, let counterType = counterType else { return }
        newValue = max(0, newValue - 1)
        setCounterValue(value: newValue)
        delegate?.counterValueDidChange(value: String(newValue), type: counterType)
        value = newValue
        if counterType == .health {
            maxHealthLabel.isHidden = false
            counterLabel.textColor = ColorConstants.healthCounterColor
        }
    }

    private func setDefaultCounterSettings() {
        guard let counterType = counterType else { return }
        switch counterType {
        case .loot:
            backgroundView.backgroundColor = ColorConstants.lootBackgroundColor
            counterLabel.textColor = ColorConstants.lootCounterColor
            counterSymbolImageView.image = UIImage(named: "lootSymbol")
            counterSymbolBackgroundImageView.image = UIImage(named: "lootSymbolShadow")
        case .health:
            backgroundView.backgroundColor = ColorConstants.healthBackgroundColor
            counterLabel.textColor = ColorConstants.maxHealthLabelColor
            counterSymbolImageView.image = UIImage(named: "healthSymbol")
            counterSymbolBackgroundImageView.image = UIImage(named: "healthSymbolShadow")
            maxHealthLabel.isHidden = true
        case .experience:
            backgroundView.backgroundColor = ColorConstants.experienceBackgroundColor
            counterLabel.textColor = ColorConstants.experienceCounterColor
            counterSymbolImageView.image = UIImage(named: "experienceSymbol")
            counterSymbolBackgroundImageView.image = UIImage(named: "experienceSymbolShadow")
        case .generic:
            backgroundView.backgroundColor = ColorConstants.genericBackgroundColor
            counterLabel.textColor = ColorConstants.genericCounterColor
        }
    }
    
    
}
