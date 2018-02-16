import UIKit

class HubViewController: UIViewController {
    
    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioLobbyID = "toScenarioLobby"
        static let segueToScenarioID = "toScenarioVC"
        static let characterCellID = "CharacterCollectionViewCell"
        static let startScenarioText = "Start Scenario"
    }
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var scenarioButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = 10
            characterImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    @IBOutlet weak var classesCollectionContainerView: UIView!
    @IBOutlet weak var showAddCharacterConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideAddCharacterButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ownedCollectionContainerView: UIView!
    @IBOutlet weak var showChangeCharacterConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideChangeCharacterButtonConstraint: NSLayoutConstraint!
    private var changeCharacterView: ChangeCharacterView?
    
    private var viewModel: HubViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()
        self.viewModel?.delegate = self
        
        setupDisplay()
    }
    
    private func setupDisplay() {
        self.navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage(named: "hvcbackground")
        scenarioButton.setTitle(Constant.startScenarioText, for: .normal)
        setupAddCharactersView()
        setupChangeCharacterView()
        guard (viewModel?.player) != nil else {
            partyNameLabel.text = viewModel?.party
            characterInfoLabel.isHidden = true
            characterImageView.isHidden = true
            return
        }
        displayPlayerInfo()
    }
    
    @IBAction func scenarioButtonTapped(_ sender: Any) {
        if scenarioButton.titleLabel?.text == Constant.startScenarioText {
            viewModel?.startScenarioCreation()
            performSegue(withIdentifier: Constant.segueToScenarioLobbyID, sender: self)
        } else {
            performSegue(withIdentifier: Constant.segueToScenarioID, sender: self)
        }
    }
    
    @IBAction func addCharacterTapped(_ sender: Any) {
        view.bringSubview(toFront: classesCollectionContainerView)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterConstraint.priority = UILayoutPriority(rawValue: 999)
            self.hideAddCharacterButtonConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func changeCharacterTapped(_ sender: Any) {
        view.bringSubview(toFront: ownedCollectionContainerView)
        if let ownedCharacters = viewModel?.ownedCharacters(), let active = viewModel?.player?.activeCharacter {
            self.changeCharacterView?.refreshData(ownedCharacters: ownedCharacters, activeCharacter: active)
        }
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showChangeCharacterConstraint.priority = UILayoutPriority(rawValue: 999)
            self.hideChangeCharacterButtonConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: Helpers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let character = viewModel?.player?.activeCharacter, let party = viewModel?.party, let service = viewModel?.service else { return }
        if segue.identifier == Constant.segueToScenarioLobbyID {
            let destinationVC = segue.destination as! ScenarioLobbyViewController
            destinationVC.configure(character: character, party: party, service: service)
        }
        if segue.identifier == Constant.segueToScenarioID {
            let destinationVC = segue.destination as! ScenarioViewController
            guard let scenario = viewModel?.scenario else { return }
            destinationVC.configure(party: party, character: character, scenario: scenario, hosting: false, service: service)
        }
    }
    
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
        changeCharacterView = Bundle.main.loadNibNamed(String(describing: ChangeCharacterView.self), owner: self, options: nil)?.first as? ChangeCharacterView
        guard let ccView = changeCharacterView else { return }
        ownedCollectionContainerView.addSubview(ccView)
        ccView.frame = ownedCollectionContainerView.bounds
        ccView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ccView.delegate = self
        guard let ownedCharacters = viewModel?.ownedCharacters(), let active = viewModel?.player?.activeCharacter else { return }
        ccView.configure(ownedCharacters: ownedCharacters, activeCharacter: active)
    }
    
    private func displayPlayerInfo() {
        partyNameLabel.text = viewModel?.party
        characterInfoLabel.isHidden = false
        characterImageView.isHidden = false
        characterImageView.image = viewModel?.activeCharacterImage()
        guard let player = viewModel?.player else { return }
        characterInfoLabel.text = "\(player.activeCharacter.name): \(String(player.activeCharacter.level))"
    }

    private func hideAddCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterConstraint.priority = UILayoutPriority.defaultLow
            self.hideAddCharacterButtonConstraint.priority = UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideChangeCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showChangeCharacterConstraint.priority = UILayoutPriority.defaultLow
            self.hideChangeCharacterButtonConstraint.priority = UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        })
    }

}

extension HubViewController: HubViewModelDelegate {
    func didCreateScenario(_ scenario: Scenario) {
        scenarioButton.setTitle("Join \(scenario.name)", for: .normal)
        scenarioButton.isEnabled = true
    }
    
    func willCreateScenario(creator: String) {
        scenarioButton.setTitle("\(creator) is setting the table...", for: .normal)
        scenarioButton.isEnabled = false
    }
    
    func didResetCreateScenario() {
        scenarioButton.setTitle(Constant.startScenarioText, for: .normal)
        scenarioButton.isEnabled = true
    }
}

extension HubViewController: AddCharactersViewDelegate, ChangeCharacterViewDelegate {
    func didRecieveCharacterForCreation(character: Character) {
        viewModel?.addCharacterToPlayer(character: character)
        hideAddCharacter()
        displayPlayerInfo()
    }
    
    func didTapAddCharacterBackButton() {
        hideAddCharacter()
    }
    
    func didSelectChangeActiveCharacter(character: Character) {
        viewModel?.setActiveCharacter(character: character)
        displayPlayerInfo()
        hideChangeCharacter()
    }
    
    func didTapChangeCharacterBackButton() {
        hideChangeCharacter()
    }
}
