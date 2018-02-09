import UIKit

protocol NumPadViewDelegate: class {
    func notShowingValidEntry()
    func showingValidEntry()
}

class NumPadView: UIView {

    weak var delegate: NumPadViewDelegate?
    
    @IBOutlet weak var amountLabel: UILabel!

    var maxNumber: Int?
    var digitsAllowed: Int?
    
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        var amount = amountLabel.text!
        if amount == "0" {
            amount = ""
            delegate?.showingValidEntry()
        }
        if let allowed = digitsAllowed {
            if amount.count < allowed {
                amount = amount + sender.titleLabel!.text!
                amountLabel.text = amount
            }
        } else { amount = amount + sender.titleLabel!.text!
                amountLabel.text = amount }
        if let max = maxNumber {
            if let amountInt = Int(amount) {
                if amountInt > max {
                    amountLabel.text = String(max)
                }
            }
        }
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        var amount = amountLabel.text!
        amount = String(amount.dropLast())
        if amount == "" {
            amount = "0"
            delegate?.notShowingValidEntry()
        }
        amountLabel.text = amount
    }

}
