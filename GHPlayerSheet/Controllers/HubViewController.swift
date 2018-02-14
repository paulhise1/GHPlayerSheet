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
    @IBOutlet weak var classesCollectionContainerView: UIView!
    
    @IBOutlet weak var changeCharacterContainerView: UIView!
    @IBOutlet weak var ownedCollectionContainerView: UIView!
    @IBOutlet weak var showChangeCharacterContainerConstraint: NSLayoutConstraint!
    
    private var viewModel: HubViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()
        
        setupDisplay()
    }
    
    private func setupDisplay() {
        self.navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage(named: "hvcbackground")
        setupAddCharactersView()
        setupChangeCharacterView()
        guard let player = viewModel?.player else {
            characterInfoLabel.isHidden = true
            characterLevelLabel.isHidden = true
            characterImageView.isHidden = true
            return
        }
        displayCharacterInfo(player: player)
    }
    
    @IBAction func addCharacterTapped(_ sender: Any) {
        view.bringSubview(toFront: addCharacterContainerView)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterContainerConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func changeCharacterTapped(_ sender: Any) {
        view.bringSubview(toFront: changeCharacterContainerView)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showChangeCharacterContainerConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: Helpers
    private func setupAddCharactersView() {
        let addCharactersView = Bundle.main.loadNibNamed(String(describing: AddCharactersView.self), owner: self, options: nil)?.first as? AddCharactersView
        if let addCharactersView = addCharactersView {
            classesCollectionContainerView.addSubview(addCharactersView)
            addCharactersView.frame = classesCollectionContainerView.bounds
            addCharactersView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addCharactersView.configure()
            addCharactersView.delegate = self
        }
    }
    
    private func setupChangeCharacterView() {
        let changeCharacterView = Bundle.main.loadNibNamed(String(describing: ChangeCharacterView.self), owner: self, options: nil)?.first as? ChangeCharacterView
        guard let ccView = changeCharacterView else { return }
        ownedCollectionContainerView.addSubview(ccView)
        ccView.frame = ownedCollectionContainerView.bounds
        ccView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ccView.delegate = self
        guard let ownedCharacters = viewModel?.ownedCharacters() else { return }
        ccView.configure(ownedCharacters: ownedCharacters)
        
    }
    
    private func hideAddCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterContainerConstraint.priority = UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideChangeCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showChangeCharacterContainerConstraint.priority = UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        })
    }
    
    private func displayCharacterInfo(player: Player) {
        characterInfoLabel.isHidden = false
        characterLevelLabel.isHidden = false
        characterImageView.isHidden = false
        characterImageView.image = viewModel?.activeCharacterImage()
        characterInfoLabel.text = player.activeCharacter.name
        characterLevelLabel.text = String(player.activeCharacter.level)
    }
}

extension HubViewController: AddCharactersViewDelegate, ChangeCharacterViewDelegate {
    
    func didRecieveCharacterForCreation(character: Character) {
        viewModel?.addCharacterToPlayer(character: character)
        hideAddCharacter()
        guard let player = viewModel?.player else { return }
        displayCharacterInfo(player: player)
    }
    
    func didTapAddCharacterBackButton() {
        hideAddCharacter()
    }
    
    func didTapChangeCharacterBackButton() {
        hideChangeCharacter()
    }
    
    func didSelectChangeActiveCharacter(character: Character) {
        
    }
}
