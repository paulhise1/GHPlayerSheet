import UIKit

class HubViewController: UIViewController {
    
    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioLobbyID = "toScenarioLobby"
        static let segueToScenarioID = "toScenarioVC"
        static let characterCellID = "CharacterCollectionViewCell"
        static let startScenarioText = "Start Scenario"
        static let viewBackgroundImage = "hvcbackground"
    }
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var partyNameLabel: UILabel!
    
    @IBOutlet weak var scenarioButton: UIButton!
    @IBOutlet weak var hostedByLabel: UILabel!
    
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = 8
            characterImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    @IBOutlet weak var addCharacterCollectionViewContainer: UIView!
    @IBOutlet weak var showAddCharacterConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideAddCharacterButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var changeCharacterButton: UIButton!
    @IBOutlet weak var changeCharacterCollectionViewContainer: UIView!
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
        backgroundImage.image = UIImage(named: Constant.viewBackgroundImage)
        scenarioButton.setTitle(Constant.startScenarioText, for: .normal)
        hostedByLabel.isHidden = true
        displayPlayerInfo()
        setupAddCharactersView()
        displayChangeCharacterButton()
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
        showAddCharacter()
    }
    
    @IBAction func changeCharacterTapped(_ sender: Any) {
        showChangeCharacter()
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
    
    private func displayPlayerInfo() {
        guard (viewModel?.player) != nil
            else {
            partyNameLabel.text = viewModel?.party
            characterInfoLabel.isHidden = true
            characterImageView.isHidden = true
            scenarioButton.isHidden = true
            return }
        partyNameLabel.text = viewModel?.party
        characterInfoLabel.isHidden = false
        characterImageView.isHidden = false
        characterImageView.image = viewModel?.activeCharacterImage()
        scenarioButton.isHidden = false
        guard let player = viewModel?.player else { return }
        characterInfoLabel.text = "\(player.activeCharacter.name): \(String(player.activeCharacter.level))"
    }

    private func showAddCharacter() {
        view.bringSubview(toFront: addCharacterCollectionViewContainer)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterConstraint.priority = UILayoutPriority(rawValue: 999)
            self.hideAddCharacterButtonConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideAddCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterConstraint.priority = UILayoutPriority.defaultLow
            self.hideAddCharacterButtonConstraint.priority = UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        })
    }
    
    private func showChangeCharacter() {
        view.bringSubview(toFront: changeCharacterCollectionViewContainer)
        setupChangeCharacterView()
        showChangeCharacterConstraint.constant = lengthOfChangeCharacterView()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showChangeCharacterConstraint.priority = UILayoutPriority(rawValue: 999)
            self.hideChangeCharacterButtonConstraint.priority = UILayoutPriority(rawValue: 999)
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
        changeCharacterView?.removeFromSuperview()
    }
    
    func displayChangeCharacterButton() {
        guard let ownedCharacters = viewModel?.ownedCharacters() else {
            self.changeCharacterButton.isHidden = true
            return
        }
        if ownedCharacters.count >= 2 {
            self.changeCharacterButton.isHidden = false
        } else {
            self.changeCharacterButton.isHidden = true
        }
    }
    
    private func lengthOfChangeCharacterView() -> CGFloat {
        let maxWidth = view.frame.size.width * 0.9
        let ccViewWidth = changeCharacterView?.itemsWidth ?? 0.0
        let padding: CGFloat = 10.0
        return min(maxWidth, ccViewWidth) + padding
    }
    
    //MARK: - setup view methods
    private func setupAddCharactersView() {
        guard let addCharactersView = Bundle.main.loadNibNamed(String(describing: AddCharactersView.self), owner: self, options: nil)?.first as? AddCharactersView else { return }
        addCharacterCollectionViewContainer.addSubview(addCharactersView)
        addCharactersView.frame = addCharacterCollectionViewContainer.bounds
        addCharactersView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addCharactersView.configure()
        addCharactersView.delegate = self
    }
    
    private func setupChangeCharacterView() {
        changeCharacterView = Bundle.main.loadNibNamed(String(describing: ChangeCharacterView.self), owner: self, options: nil)?.first as? ChangeCharacterView
        guard let changeCharacterView = changeCharacterView, let ownedCharacters = viewModel?.ownedCharacters(), let active = viewModel?.player?.activeCharacter else { return }
        changeCharacterCollectionViewContainer.addSubview(changeCharacterView)
        changeCharacterView.frame = changeCharacterCollectionViewContainer.bounds
        changeCharacterView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        changeCharacterView.delegate = self
        changeCharacterView.configure(ownedCharacters: ownedCharacters, activeCharacter: active)
    }
}

extension HubViewController: HubViewModelDelegate {
    func didCreateScenario(_ scenario: Scenario) {
        scenarioButton.setTitle("Join \(scenario.name)", for: .normal)
        scenarioButton.isEnabled = true
        hostedByLabel.isHidden = true
    }
    
    func willCreateScenario(creator: String) {
        hostedByLabel.isHidden = false
        scenarioButton.setTitle("Scenario being prepared ", for: .normal)
        hostedByLabel.text = "by: \(creator)"
        scenarioButton.isEnabled = false
    }
    
    func didCancelScenarioCreation() {
        scenarioButton.setTitle(Constant.startScenarioText, for: .normal)
        scenarioButton.isEnabled = true
        hostedByLabel.isHidden = true
    }
}

extension HubViewController: AddCharactersViewDelegate, ChangeCharacterViewDelegate {
    func didRecieveCharacterForCreation(character: Character) {
        viewModel?.addCharacterToPlayer(character: character)
        hideAddCharacter()
        displayPlayerInfo()
        displayChangeCharacterButton()
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
