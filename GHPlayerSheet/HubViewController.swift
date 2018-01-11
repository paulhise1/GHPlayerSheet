import UIKit

class HubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createCharacter(_ sender: Any) {
        
    }
   
    

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterModel = CharacterModel(classType: .cragheart, name: "Orsaf", level: 1)
        let characterSheetVC = segue.destination as! CharacterSheetViewController
        characterSheetVC.characterModel = characterModel
    }
    

}
