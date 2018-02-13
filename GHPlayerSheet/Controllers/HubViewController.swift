import UIKit

class HubViewController: UIViewController {
    
    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let characterCellID = "CharacterCollectionViewCell"
    }
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var beginScenarioButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterInfoLabel: UILabel!
    @IBOutlet weak var characterLevelLabel: UILabel!
    
    @IBOutlet weak var addCharacterContainerView: UIView!
    @IBOutlet weak var showAddCharacterContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewContainerView: UIView!
    
    private var viewModel: HubViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()
        
        setupDisplay()
    }
    
    private func setupDisplay() {
        self.navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage(named: "hvcbackground")
        self.setupAddCharactersView()
        guard let player = viewModel?.player else {
            characterInfoLabel.isHidden = true
            characterLevelLabel.isHidden = true
            characterImageView.isHidden = true
            return
        }
        characterImageView.image = viewModel?.activeCharacterImage()
        characterInfoLabel.text = player.activeCharacter.name
        characterLevelLabel.text = String(player.activeCharacter.level)
    }
    
    @IBAction func addCharacterTapped(_ sender: Any) {
        view.bringSubview(toFront: backgroundImage)
        view.bringSubview(toFront: addCharacterContainerView)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterContainerConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: Helpers
    private func setupAddCharactersView() {
        let addCharactersView = Bundle.main.loadNibNamed(String(describing: AddCharactersView.self), owner: self, options: nil)?.first as? AddCharactersView
        if let addCharactersView = addCharactersView {
            collectionViewContainerView.addSubview(addCharactersView)
            addCharactersView.frame = collectionViewContainerView.bounds
            addCharactersView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addCharactersView.configure()
            addCharactersView.delegate = self
        }
    }
    
    private func hideAddCharacter(){
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterContainerConstraint.priority = UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        })
        self.view.sendSubview(toBack: self.backgroundImage)
    }
}

extension HubViewController: AddCharactersViewDelegate {
    func didRecieveCharacterForCreation(character: Character) {
        viewModel?.addCharacterToPlayer(character: character)
        hideAddCharacter()
    }
    
    func didTapBackButton() {
        hideAddCharacter()
    }
}
