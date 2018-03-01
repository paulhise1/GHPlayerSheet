import UIKit

class HubViewController: UIViewController {
    
    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let segueToScenarioLobbyID = "toScenarioLobby"
        static let segueToScenarioID = "toScenarioVC"
        static let characterCellID = "CharacterCollectionViewCell"
        static let startScenarioText = "Start Scenario"
        static let viewBackgroundImage = "hvcbackground"
        static let characterSheetStoryboardID = "characterSheet"
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
    
    @IBOutlet weak var addCharacterCollectionViewContainer: UIView!
    @IBOutlet weak var showAddCharacterConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideAddCharacterButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var changeCharacterButton: UIButton!
    @IBOutlet weak var changeCharacterCollectionViewContainer: UIView!
    @IBOutlet weak var showChangeCharacterConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideChangeCharacterButtonConstraint: NSLayoutConstraint!
    private var changeCharacterView: ChangeCharacterView?
    
    private var characterSheetView: CharacterSheetViewController?
    @IBOutlet weak var characterSheetButton: UIButton!
    @IBOutlet weak var characterSheetTabContainer: UIView!
    @IBOutlet weak var characterSheetTabLabel: UILabel!
    @IBOutlet weak var characterSheetTabImage: UIImageView!
    @IBOutlet weak var characterSheetTabLevelLabel: UILabel!
    @IBOutlet weak var characterSheetContainer: UIView!
    @IBOutlet weak var showCharacterSheetConstraint: NSLayoutConstraint!
    
    private var viewModel: HubViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HubViewModel()
        self.viewModel?.delegate = self
        setupDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.setScenarioStatusListener()
        viewModel?.writePlayerToDatasourceToSaveActiveCharacter()
    }
    
    private func setupDisplay() {
        self.navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage(named: Constant.viewBackgroundImage)
        scenarioButton.isHidden = true
        hostedByLabel.isHidden = true
        characterSheetTabContainer.isHidden = true
        displayPlayerInfo()
        setupAddCharactersView()
        displayChangeCharacterButton()
    }
    
    @IBAction func characterSheetButtonTapped(_ sender: Any) {
        setupCharacterSheetView()
        characterSheetTabLabel.text = viewModel?.activeCharacterTypeString()
        characterSheetTabLevelLabel.text = viewModel?.activeCharacterLevelString()
        guard let characterType = viewModel?.activeCharacterType() else { return }
        let characterColor = ClassTypeData.characterColor(charClass: characterType)
        characterSheetTabLabel.textColor = characterColor
        characterSheetTabLevelLabel.textColor = characterColor
        showCharacterSheetConstraint.priority = UILayoutPriority(rawValue: 700)
        characterSheetTabContainer.isHidden = false
    }
    
    @IBAction func characterSheetTabButtonTapped(_ sender: Any) {
        showCharacterSheetConstraint.priority = UILayoutPriority(rawValue: 200)
        characterSheetView?.view.removeFromSuperview()
        characterSheetTabContainer.isHidden = true
    }
    
    @IBAction func scenarioButtonTapped(_ sender: Any) {
        if scenarioButton.titleLabel?.text == Constant.startScenarioText {
            viewModel?.startScenarioCreation()
            scenarioButton.setTitle("", for: .normal)
            performSegue(withIdentifier: Constant.segueToScenarioLobbyID, sender: self)
        } else {
            scenarioButton.setTitle("", for: .normal)
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
            characterSheetButton.isHidden = true
            characterImageView.isHidden = true
            scenarioButton.isHidden = true
            return }
        partyNameLabel.text = viewModel?.party
        characterImageView.isHidden = false
        characterImageView.image = viewModel?.activeCharacterImage()
        scenarioButton.isHidden = false
        characterSheetButton.isHidden = false
        guard let player = viewModel?.player else { return }
        characterSheetButton.setTitle("\(player.activeCharacter.name): \(String(player.activeCharacter.level))", for: .normal)
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
    
    private func setupCharacterSheetView() {
        characterSheetView = storyboard?.instantiateViewController(withIdentifier: Constant.characterSheetStoryboardID) as? CharacterSheetViewController
        guard let characterSheetView = characterSheetView else { return }
        guard let activeCharacter = viewModel?.player?.activeCharacter else { return }
        characterSheetView.configure(character: activeCharacter)
        addChildViewController(characterSheetView)
        characterSheetView.view.frame = characterSheetContainer.bounds
        characterSheetView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        characterSheetContainer.addSubview(characterSheetView.view)
        characterSheetView.didMove(toParentViewController: self)
    }
}

extension HubViewController: HubViewModelDelegate {
    func didCreateScenario(_ scenario: Scenario) {
        scenarioButton.setTitle("", for: .normal)
        scenarioButton.setTitle("Join \(scenario.name)", for: .normal)
        scenarioButton.isEnabled = true
        hostedByLabel.isHidden = true
        if viewModel?.player?.activeCharacter != nil {
            scenarioButton.isHidden = false
        }
    }
    
    func willCreateScenario(creator: String) {
        hostedByLabel.isHidden = false
        scenarioButton.setTitle("", for: .normal)
        scenarioButton.setTitle("Scenario being prepared ", for: .normal)
        hostedByLabel.text = "by: \(creator)"
        scenarioButton.isEnabled = false
        if viewModel?.player?.activeCharacter != nil {
            scenarioButton.isHidden = false
        }
    }
    
    func didCancelScenarioCreation() {
        scenarioCreationEnabled()
    }
    
    func noCurrentScenario() {
        scenarioCreationEnabled()
    }
    
    private func scenarioCreationEnabled() {
        scenarioButton.isHidden = false
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
