import UIKit

protocol PartyInviteViewDelegate: class {
    func joinParty(partyName: String)
    func dismissPartyInviteView()
}

class PartyInviteView: UIView {
    
    struct Constant {
        static let broadcastPartyInviteMessage = "Broadcasting Party Invite"
        static let joinMessage = "Searching For Party Invite"
        static let partyInviteTableViewCell = "partyInviteTableViewCell"
    }

    weak var delegate: PartyInviteViewDelegate?
    
    @IBOutlet weak var messageViewContainer: UIView!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var partyInviteMessage: UILabel!
    
    private var viewModel: PartyInviteViewModel?
    private var partyName: String?
    
    func configureForJoiningParty() {
        self.viewModel = PartyInviteViewModel()
        self.viewModel?.delegate = self
        searchForParties()
    }
    
    func configureForPartyInviting(partyName: String) {
        self.viewModel = PartyInviteViewModel()
        self.viewModel?.delegate = self
        self.partyName = partyName
        broadcastInvite()
    }
    
    func removePartyService() {
        viewModel?.stopAcceptingInvites()
        viewModel?.stopBroadcastPartyInvite()
    }
    
    private func broadcastInvite() {
        guard let partyName = partyName else { return }
        viewModel?.broadcastPartyInvite(partyName: partyName)
        partyInviteMessage.text = Constant.broadcastPartyInviteMessage
        buttonContainer.isHidden = true
    }
    
    private func searchForParties() {
        buttonContainer.isHidden = true
        partyInviteMessage.text = Constant.joinMessage
        viewModel?.beginAcceptingInvites()
    }
    
    private func displayPartyInvite(partyName: String) {
        let message = "Would you like to join \(partyName)?"
        buttonContainer.isHidden = false
        partyInviteMessage.text = message
    }
    
    @IBAction func declineInvitationButtonTapped(_ sender: Any) {
        delegate?.dismissPartyInviteView()
    }
    
    @IBAction func AcceptInvitationButtonTapped(_ sender: Any) {
        guard let partyName = self.partyName else { return }
        delegate?.joinParty(partyName: partyName)
        delegate?.dismissPartyInviteView()
    }
}

extension PartyInviteView: PartyInviteViewModelDelegate {
    func receivedInvite(partyName: String) {
        self.partyName = partyName
        displayPartyInvite(partyName: partyName)
    }
}


