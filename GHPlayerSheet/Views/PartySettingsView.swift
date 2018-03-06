import UIKit

protocol PartySettingsViewDelegate: class {
    func didTapCreateParty()
    func didJoinParty(partyName: String)
}

class PartySettingsView: UIView {

    @IBOutlet weak var partyInviteContainer: UIView!
    @IBOutlet weak var settingsButtonsStack: UIStackView!
    
    weak var delegate: PartySettingsViewDelegate?
    
    private var partyInviteView: PartyInviteView?
    private var partyName: String?
    
    func configure(partyName: String?) {
        self.partyName = partyName
    }
    
    func updatePartyName(partyName: String) {
        self.partyName = partyName
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        setupPartyInviteView()
    }
    
    @IBAction func createPartyButtonTapped(_ sender: Any) {
        delegate?.didTapCreateParty()
    }
    
    func endPartyServiceConnections() {
        partyInviteView?.removePartyService()
    }
    
    private func setupPartyInviteView() {
        settingsButtonsStack.isHidden = true
        bringSubview(toFront: partyInviteContainer)
        partyInviteView = Bundle.main.loadNibNamed(String(describing: PartyInviteView.self), owner: self, options: nil)?.first as? PartyInviteView
        guard let partyInviteView = self.partyInviteView else { return }
        partyInviteView.frame = partyInviteContainer.bounds
        partyInviteView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        partyInviteContainer.addSubview(partyInviteView)
        partyInviteView.delegate = self
        partyInviteView.configure(partyName: partyName)
        guard partyName == "Default" else { return }
        partyInviteView.shareButton.isEnabled = false
    }
}

extension PartySettingsView: PartyInviteViewDelegate {
    func didJoinParty(partyName: String) {
        delegate?.didJoinParty(partyName: partyName)
    }
    
    func finishedWithPartyInviteView() {
        settingsButtonsStack.isHidden = false
        bringSubview(toFront: settingsButtonsStack)
        partyInviteView?.removeFromSuperview()
    }
    
    
}
