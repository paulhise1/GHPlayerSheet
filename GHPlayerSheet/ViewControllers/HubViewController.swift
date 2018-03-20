import UIKit
import DynamicBlurView

class HubViewController: UIViewController {
    
    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let characterCellID = "CharacterCollectionViewCell"
        static let viewBackgroundImage = "hvcbackground"
        static let invitingView = "inviting"
        static let joiningView = "joining"
        static let noPartyTitle = "Create or Join Party"
        static let partyNamePlaceholder = "Enter Party Name"
        static let createCharacter = "Create A Character"
    }
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var partyNameButton: UIButton! {
        didSet {
            partyNameButton.layer.cornerRadius = 4
            partyNameButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var hidePartyStatHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var characterImageView: UIImageView! 
    
    @IBOutlet weak var characterContainer: UIView! {
        didSet {
            characterContainer.layer.cornerRadius = 4
            characterContainer.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var addCharacterCollectionViewContainer: UIView!
    @IBOutlet weak var showAddCharacterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var changeCharacterButtonContainer: UIView!
    
    @IBOutlet weak var changeCharacterCollectionViewContainer: UIView!
    @IBOutlet weak var showChangeCharacterConstraint: NSLayoutConstraint!
    private var changeCharacterView: ChangeCharacterView?
    
    private var characterSheetView: CharacterSheetViewController?
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    @IBOutlet weak var partySettingsContainer: UIView!
    @IBOutlet weak var bannerBottomImageView: UIImageView!
    private var partySettingsView: PartySettingsView?
    
    private var viewModel: HubViewModel?
    private var partyInviteService: MPCPartyInviteService?
    private var blurView: DynamicBlurView?
    private var textField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HubViewModel()
        self.viewModel?.delegate = self
        setupDisplay()
        partyInviteService = MPCPartyInviteService()
    }

    private func setupDisplay() {
        self.navigationController?.isNavigationBarHidden = true
        backgroundImage.image = UIImage(named: Constant.viewBackgroundImage)
        displayPlayerInfo()
        setupAddCharactersView()
        displayChangeCharacterButton()
    }
    
    @IBAction func partyNameButtonTapped(_ sender: Any) {
        if hidePartyStatHeightConstraint.priority.rawValue == 200 {
            hidePartySettings()
        } else {
            showPartySettings()
        }
    }

    private func showPartySettings() {
        setupPartySettingsView()
        addBlurBehindPartySettings()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.hidePartyStatHeightConstraint.priority = UILayoutPriority(rawValue: 200)
            self.view.layoutIfNeeded()
        })
    }
    
    private func addBlurBehindPartySettings() {
        addBlurEffect()
        view.bringSubview(toFront: partyNameButton)
        view.bringSubview(toFront: partySettingsContainer)
        view.bringSubview(toFront: bannerBottomImageView)
    }
    
    private func hidePartySettings() {
        removeBlurEffect()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.hidePartyStatHeightConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
        partySettingsView?.endPartyServiceConnections()
        partySettingsView?.removeFromSuperview()
    }
    
    @IBAction func addCharacterTapped(_ sender: Any) {
        showAddCharacter()
    }
    
    @IBAction func changeCharacterTapped(_ sender: Any) {
        showChangeCharacter()
    }
    
    @IBAction func characterSheetButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: Helpers
    private func displayPlayerInfo() {
        setPartyNameButtonLabel()
        guard let player = viewModel?.player else { return }
        guard let name = player.activeCharacter()?.name else {
            characterInfoLabel.text = Constant.createCharacter
            return }
        guard let level = player.activeCharacter()?.level else { return }
        guard let classType = player.activeCharacter()?.classType else { return }
        characterImageView.isHidden = false
        characterImageView.image = viewModel?.activeCharacterColorIcon()
        characterInfoLabel.text = "\(name): \(String(level))"
        characterInfoLabel.textColor = ClassTypeData.characterColor(charClass: classType)

    }

    private func setPartyNameButtonLabel() {
        guard let party = viewModel?.activeParty() else {
            partyNameButton.setTitle("  \(Constant.noPartyTitle)  ", for: .normal)
            return }
        guard party.name != "Default" else {
            partyNameButton.setTitle("  \(Constant.noPartyTitle)  ", for: .normal)
            return }
        partyNameButton.setTitle("  \(party.name)  ", for: .normal)
    }
    
    private func showAddCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.addBlurEffect()
            self.view.bringSubview(toFront: self.addCharacterCollectionViewContainer)
            self.showAddCharacterConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideAddCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showAddCharacterConstraint.priority = UILayoutPriority(rawValue: 300)
            self.view.layoutIfNeeded()
        })
        removeBlurEffect()
    }
    
    private func showChangeCharacter() {
        addBlurEffect()
        view.bringSubview(toFront: changeCharacterCollectionViewContainer)
        setupChangeCharacterView()
        showChangeCharacterConstraint.constant = lengthOfChangeCharacterView()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showChangeCharacterConstraint.priority = UILayoutPriority(rawValue: 999)
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideChangeCharacter() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.showChangeCharacterConstraint.priority = UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        })
        removeBlurEffect()
        changeCharacterView?.removeFromSuperview()
    }
    
    func displayChangeCharacterButton() {
        guard let ownedCharacters = viewModel?.ownedCharacters() else {
            self.changeCharacterButtonContainer.isHidden = true
            return
        }
        if ownedCharacters.count >= 2 {
            self.changeCharacterButtonContainer.isHidden = false
        } else {
            self.changeCharacterButtonContainer.isHidden = true
        }
    }
    
    private func lengthOfChangeCharacterView() -> CGFloat {
        let maxWidth = view.frame.size.width * 0.9
        let ccViewWidth = changeCharacterView?.itemsWidth ?? 0.0
        let padding: CGFloat = 45.0
        return min(maxWidth, ccViewWidth) + padding
    }

    private func createPartyWithName(_ name: String) {
        guard name != "" else { return }
        viewModel?.createParty(partyName: name)
        settingsViewUpdateParties()
    }
    
    private func settingsViewUpdateParties() {
        guard let parties = viewModel?.player?.partyArray() else { return }
        partySettingsView?.updateParties(parties: parties)
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
        guard let changeCharacterView = changeCharacterView, let ownedCharacters = viewModel?.ownedCharacters(), let active = viewModel?.player?.activeCharacter() else { return }
        changeCharacterCollectionViewContainer.addSubview(changeCharacterView)
        changeCharacterView.frame = changeCharacterCollectionViewContainer.bounds
        changeCharacterView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        changeCharacterView.delegate = self
        changeCharacterView.configure(ownedCharacters: ownedCharacters, activeCharacter: active)
    }
    
    private func setupPartySettingsView() {
        partySettingsView = Bundle.main.loadNibNamed(String(describing: PartySettingsView.self), owner: self, options: nil)?.first as? PartySettingsView
        guard let partySettingsView = partySettingsView else { return }
        partySettingsView.frame = partySettingsContainer.bounds
        partySettingsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        partySettingsContainer.addSubview(partySettingsView)
        partySettingsView.delegate = self
        guard let parties = viewModel?.player?.partyArray() else {
            partySettingsView.configure(parties: nil)
            return }
        partySettingsView.configure(parties: parties)
    }
}

extension HubViewController: HubViewModelDelegate {
    func didDeleteActiveParty() {
        setPartyNameButtonLabel()
    }
    
    func didSetActiveParty(activeParty: Party) {
        guard let viewModel = viewModel, let name = viewModel.activeParty()?.name else { return }
        partyNameButton.setTitle("  \(name)  ", for: .normal)
        settingsViewUpdateParties()
    }
}

extension HubViewController: PartySettingsViewDelegate {
    func
        didSelectParty(_ party: Party) {
        viewModel?.setActiveParty(party)
        setPartyNameButtonLabel()
    }
    
    func didDeleteParty(party: Party) {
        viewModel?.deleteParty(party: party)
        settingsViewUpdateParties()
        setPartyNameButtonLabel()
    }
    
    func didChooseCreateParty() {
        removeBlurEffect()
        addBlurEffect()
        displayPartyCreationTextfield()
    }
    
    func didJoinParty(partyName: String) {
        createPartyWithName(partyName)
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

extension HubViewController: UITextFieldDelegate {
    func displayPartyCreationTextfield() {
        self.textField = UITextField()
        let width: CGFloat = 200.0
        let frame = CGRect(x: view.frame.size.width/2-width/2, y: 100, width: width, height: 40)
        guard let textField = self.textField else { return }
        textField.frame = frame
        textField.delegate = self
        textField.backgroundColor = UIColor(white: 0, alpha: 0.5)
        textField.returnKeyType = .done
        textField.font = FontConstants.characterSheetNameText
        textField.placeholder = Constant.partyNamePlaceholder
        textField.textColor = UIColor.flatWhite()
        textField.becomeFirstResponder()
        view.addSubview(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        removeBlurEffect()
        guard let textFieldText = textField.text else { return true }
        createPartyWithName(textFieldText)
        removePartyNameTextfield()
        textField.endEditing(true)
        addBlurBehindPartySettings()
        return true
    }
    
    private func removePartyNameTextfield() {
        guard let textField = self.textField else { return }
        textField.removeFromSuperview()
        self.textField = nil
    }
}

extension HubViewController {
    func addBlurEffect(){
        // Would like to animate, animation was stuttered
        blurView = nil
        blurView = DynamicBlurView(frame: view.bounds)
        blurView?.isUserInteractionEnabled = true
        blurView?.blurRadius = 2
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.dismissActiveView(sender:)))
        if let blurView = blurView {
            view.addSubview(blurView)
            blurView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func dismissActiveView(sender : UITapGestureRecognizer) {
        guard self.textField == nil else {
            removePartyNameTextfield()
            removeBlurEffect()
            addBlurBehindPartySettings()
            return }
        hideChangeCharacter()
        hideAddCharacter()
        hidePartySettings()
        removeBlurEffect()
    }
    
    func removeBlurEffect(){
        blurView?.blurRadius = 0
        blurView?.removeFromSuperview()
    }
}
