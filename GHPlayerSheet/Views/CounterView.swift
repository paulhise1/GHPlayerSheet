import UIKit

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
    
    var counterValue = 0
    
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    
    @IBAction func decrementButtonTapped(_ sender: Any) {
        if counterValue > 0 {
            counterValue = counterValue - 1
            counterLabel.text = String(counterValue)
            delegate?.valueDidChange(value: counterValue)
        }
    }
    
    @IBAction func incrementButtonTapped(_ sender: Any) {
        counterValue = counterValue + 1
            counterLabel.text = String(counterValue)
            delegate?.valueDidChange(value: counterValue)
        }
    
    
    func setValue(value: Int) {
        counterValue = value
    }
    
    
}
