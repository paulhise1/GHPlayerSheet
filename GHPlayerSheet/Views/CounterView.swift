import UIKit
import ChameleonFramework

enum CounterType {
    case generic
    case health
    case experience
}

protocol CounterViewDelegate: class {
    func counterValueDidChange(value: Int, sender: CounterView)
}

class CounterView: UIView {

    weak var delegate: CounterViewDelegate?
    
    private var counterType = CounterType.generic
    private var counterValue = 0
    private var max: Int? = nil
    
    // Color Contants
    let healthBackgroundColor = UIColor.flatRedColorDark()
    let healthCounterColor = UIColor.flatWatermelon().lighten(byPercentage: 0.9)
    let experienceBackgroundColor = UIColor.flatSkyBlueColorDark()
    let experienceCounterColor = UIColor.flatSkyBlue().lighten(byPercentage: 0.9)
    let genericBackgroundColor = UIColor.flatMagentaColorDark()
    let genericCounterColor = UIColor.flatMagenta().lighten(byPercentage: 0.75)
    
    
    @IBOutlet private weak var decrementButton: UIButton!
    @IBOutlet private weak var incrementButton: UIButton!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 18
            backgroundView.layer.masksToBounds = true
        }
    }
    
    // might want to add press and hold functionality
    @IBAction func incrementButtonTapped(_ sender: Any) {
        if let maxValue = max {
            if counterValue < maxValue {
                incrementCounter()
            }
        } else {
            incrementCounter()
        }
    }
    
    @IBAction func decrementButtonTapped(_ sender: Any) {
        if counterValue > 0 {
            decrementCounter()
        }
    }
    
    func setupCounter(startingValue: Int, type: CounterType, maxValue: Int? = nil) {
        counterType = type
        max = maxValue
        setCounterValue(value: startingValue)
        setDefaultColors()
    }
    
    private func setCounterValue(value: Int) {
        counterValue = value
        counterLabel.text = String(counterValue)
    }
    
    private func setDefaultColors() {
        switch counterType {
        case .health:
            backgroundView.backgroundColor = healthBackgroundColor
            counterLabel.textColor = healthCounterColor
        case .experience:
            backgroundView.backgroundColor = experienceBackgroundColor
            counterLabel.textColor = experienceCounterColor
        case .generic:
            backgroundView.backgroundColor = genericBackgroundColor
            counterLabel.textColor = genericCounterColor
        }
    }
    
    private func incrementCounter() {
        counterValue = counterValue + 1
        counterLabel.text = String(counterValue)
        delegate?.counterValueDidChange(value: counterValue, sender: self)
    }
    
    private func decrementCounter() {
        counterValue = counterValue - 1
        counterLabel.text = String(counterValue)
        delegate?.counterValueDidChange(value: counterValue, sender: self)
    }
}
