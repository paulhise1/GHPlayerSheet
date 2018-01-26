import UIKit

class CheckmarksView: UIView {

    private var buttonList = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    @IBOutlet var checkmarkBoxButton: [UIButton]!
    
    func configureColorBackground() {
        self.layer.backgroundColor = ColorConstants.checkmarksViewBackground?.cgColor
    }
    
    @IBAction func checkBoxOneTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 0)
    }
    @IBAction func checkBoxTwoTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 1)
    }
    @IBAction func checkBoxThreeTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 2)
    }
    @IBAction func checkBoxFourTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 3)
    }
    @IBAction func checkBoxFiveTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 4)
    }
    @IBAction func checkBoxSixTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 5)
    }
    @IBAction func checkBoxSevenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 6)
    }
    @IBAction func checkBoxEightTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 7)
    }
    @IBAction func checkBoxNineTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 8)
    }
    @IBAction func checkBoxTenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 9)
    }
    @IBAction func checkBoxElevenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 10)
    }
    @IBAction func checkBoxTwelveTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 11)
    }
    @IBAction func checkBoxThirteenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 12)
    }
    @IBAction func checkBoxFourteenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 13)
    }
    @IBAction func checkBoxFifteenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 14)
    }
    @IBAction func checkBoxSixteenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 15)
    }
    @IBAction func checkBoxSeventeenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 16)
    }
    @IBAction func checkBoxEighteenTapped(_ sender: Any) {
        didToggleCheckBox(buttonIndex: 17)
    }
    
    func didToggleCheckBox(buttonIndex: Int) {
        let checkedBoxImage = UIImage.init(named: "checkedBox")
        let emptyCheckBoxImage = UIImage.init(named: "emptyCheckBox")
        
        if buttonList[buttonIndex] {
            buttonList[buttonIndex] = false
            checkmarkBoxButton[buttonIndex].setImage(emptyCheckBoxImage, for: .normal)
        } else {
            buttonList[buttonIndex] = true
            checkmarkBoxButton[buttonIndex].setImage(checkedBoxImage, for: .normal)
        }
    }



}
