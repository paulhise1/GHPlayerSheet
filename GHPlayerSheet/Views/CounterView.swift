import UIKit
import ChameleonFramework

enum CounterType {
    case generic
    case health
    case experience
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
            backgroundView.layer.cornerRadius = 18
            backgroundView.layer.masksToBounds = true
        }
    }
    
    func configure(value: String = "0", counterType: CounterType = .generic, maxValue: String? = nil) {
        self.value = Int(value)
        self.counterType = counterType
        if let maxValue = maxValue { self.maxValue = Int(maxValue) }
        setDefaultColors()
        counterLabel.text = String(value)
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
        counterLabel.text = String(newValue)
        delegate?.counterValueDidChange(value: String(newValue), type: counterType)
        value = newValue
    }
    
    private func decrementCounter() {
        guard var newValue = value, let counterType = counterType else { return }
        newValue = max(0, newValue - 1)
        counterLabel.text = String(newValue)
        delegate?.counterValueDidChange(value: String(newValue), type: counterType)
        value = newValue
    }
    
    private func setDefaultColors() {
        switch counterType {
        case .health?:
            backgroundView.backgroundColor = ColorConstants.healthBackgroundColor
            counterLabel.textColor = ColorConstants.healthCounterColor
        case .experience?:
            backgroundView.backgroundColor = ColorConstants.experienceBackgroundColor
            counterLabel.textColor = ColorConstants.experienceCounterColor
        default:
            backgroundView.backgroundColor = ColorConstants.genericBackgroundColor
            counterLabel.textColor = ColorConstants.genericCounterColor
        }
    }
}
