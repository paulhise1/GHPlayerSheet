import UIKit
import ChameleonFramework

enum CounterType {
    case generic
    case health
    case experience
}

protocol CounterViewDelegate: class {
    func valueDidChange(value: Int)
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
    
    
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 20
            backgroundView.layer.masksToBounds = true
        }
    }
    
    // might want to add press and hold functionality
    @IBAction func decrementButtonTapped(_ sender: Any) {
        if counterValue > 0 {
            decrementCounter()
        }
    }
    
    @IBAction func incrementButtonTapped(_ sender: Any) {
        if let maxValue = max {
            if counterValue < maxValue {
                incrementCounter()
            }
        } else {
            incrementCounter()
        }
    }
    
    func setupCounter(startingValue: Int, type: CounterType, maxValue: Int? = nil) {
        counterType = type
        max = maxValue
        setValue(value: startingValue)
        setColors()
    }
    
    private func setValue(value: Int) {
        counterValue = value
        counterLabel.text = String(counterValue)
    }
    
    private func setColors() {
        switch counterType {
        case .health:
            backgroundView.backgroundColor = healthBackgroundColor
            counterLabel.textColor = healthCounterColor
        case .experience:
            backgroundView.backgroundColor = experienceBackgroundColor
            counterLabel.textColor = experienceCounterColor
        case .generic:
            backgroundView.backgroundColor = UIColor.flatMagenta()
        }
    }
    
    private func incrementCounter() {
        counterValue = counterValue + 1
        counterLabel.text = String(counterValue)
        delegate?.valueDidChange(value: counterValue)
    }
    
    private func decrementCounter() {
        counterValue = counterValue - 1
        counterLabel.text = String(counterValue)
        delegate?.valueDidChange(value: counterValue)
    }
}
