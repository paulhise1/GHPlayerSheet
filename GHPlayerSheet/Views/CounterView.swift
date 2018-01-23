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
    
    private var counterType: CounterType = .generic
    private var counterValue: Int = 0
    private var max: Int?
    
    @IBOutlet private weak var decrementButton: UIButton!
    @IBOutlet private weak var incrementButton: UIButton!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 18
            backgroundView.layer.masksToBounds = true
        }
    }
    
    func setupCounter(startingValue: Int, type: CounterType, maxValue: Int? = nil) {
        counterValue = startingValue
        counterType = type
        max = maxValue
        setDefaultColors()
        counterLabel.text = String(counterValue)
    }
    
    @IBAction func incrementButtonTapped(_ sender: Any) {
        incrementCounter()
    }
    
    @IBAction func decrementButtonTapped(_ sender: Any) {
        decrementCounter()
    }
    
    private func setCounterValue(value: Int) {
        counterValue = value
        counterLabel.text = String(counterValue)
    }
    
    private func setDefaultColors() {
        switch counterType {
        case .health:
            backgroundView.backgroundColor = Constants.healthBackgroundColor
            counterLabel.textColor = Constants.healthCounterColor
        case .experience:
            backgroundView.backgroundColor = Constants.experienceBackgroundColor
            counterLabel.textColor = Constants.experienceCounterColor
        case .generic:
            backgroundView.backgroundColor = Constants.genericBackgroundColor
            counterLabel.textColor = Constants.genericCounterColor
        }
    }
    
    private func incrementCounter() {
        if let maxValue = max {
            if counterValue < maxValue {
                counterValue = counterValue + 1
                counterLabel.text = String(counterValue)
                delegate?.counterValueDidChange(value: counterValue, type: counterType)
            }
        } else {
            counterValue = counterValue + 1
            counterLabel.text = String(counterValue)
            delegate?.counterValueDidChange(value: counterValue, type: counterType)
        }
        
    }
    
    private func decrementCounter() {
        if counterValue > 0 {
            counterValue = counterValue - 1
            counterLabel.text = String(counterValue)
            delegate?.counterValueDidChange(value: counterValue, type: counterType)
        }
    }
    
}
