import UIKit

class PerksViewController: UIViewController {

    var earnedPerks: [PerkModel]?
    var perkList: [PerkModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PerkToAddViewController
        
        //destinationVC.delegate = self
    }
    
}




