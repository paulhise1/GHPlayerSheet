import UIKit

class CharacterSheetViewController: UIViewController {

    var characterModel : CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        className.text = characterModel?.classType.rawValue
        characterName.text = characterModel?.name
        level.text = String(describing: characterModel!.level)
    }

    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var level: UILabel!
    
}
