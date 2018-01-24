import UIKit
import ChameleonFramework

enum CounterType {
    case generic
    case health
    case experience
}

//MARK: - Constants
struct Constants {
    static let healthBackgroundColor = UIColor.flatRedColorDark()
    static let healthCounterColor = UIColor.flatWatermelon().lighten(byPercentage: 0.9)
    static let experienceBackgroundColor = UIColor.flatSkyBlueColorDark()
    static let experienceCounterColor = UIColor.flatSkyBlue().lighten(byPercentage: 0.9)
    static let genericBackgroundColor = UIColor.flatMagentaColorDark()
    static let genericCounterColor = UIColor.flatMagenta().lighten(byPercentage: 0.75)
}

protocol CounterViewDelegate: class {
    func counterValueDidChange(value: Int, type: CounterType)
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
    
    func configure(value: Int = 0, counterType: CounterType = .generic, maxValue: Int? = nil) {
        self.value = value
        self.counterType = counterType
        self.maxValue = maxValue
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
    
    private func setDefaultColors() {
        switch counterType {
        case .health?:
            backgroundView.backgroundColor = Constants.healthBackgroundColor
            counterLabel.textColor = Constants.healthCounterColor
        case .experience?:
            backgroundView.backgroundColor = Constants.experienceBackgroundColor
            counterLabel.textColor = Constants.experienceCounterColor
        default:
            backgroundView.backgroundColor = Constants.genericBackgroundColor
            counterLabel.textColor = Constants.genericCounterColor
        }
    }
    
    private func incrementCounter() {
        guard var newValue = value, let counterType = counterType else { return }
        if let maxValue = maxValue {
            newValue = min(newValue + 1, maxValue)
        } else {
            newValue = newValue + 1
        }
        counterLabel.text = String(newValue)
        delegate?.counterValueDidChange(value: newValue, type: counterType)
        value = newValue
    }
    
    private func decrementCounter() {
        guard var newValue = value, let counterType = counterType else { return }
        newValue = max(0, newValue - 1)
        counterLabel.text = String(newValue)
        delegate?.counterValueDidChange(value: newValue, type: counterType)
        value = newValue
    }
    
}
