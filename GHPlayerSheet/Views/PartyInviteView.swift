import UIKit

protocol PartyInviteViewDelegate: class {
    func didJoinParty(partyName: String)
    func finishedWithPartyInviteView()
}

class PartyInviteView: UIView {
    
    struct Constant {
        static let broadcastPartyInviteMessage = "Broadcasting Party Invite"
        static let joinMessage = "Searching For Party Invite"
        static let partyInviteTableViewCell = "partyInviteTableViewCell"
        static let defaultMessageText = "Share your party or Join a friends."
    }

    weak var delegate: PartyInviteViewDelegate?
    
    @IBOutlet weak var messageViewContainer: UIView!
    @IBOutlet weak var InvitationAnswerButtonContainer: UIView!
    @IBOutlet weak var partyShareButtonContainer: UIView!
    @IBOutlet weak var partyInviteMessage: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    private var viewModel: PartyInviteViewModel?
    private var partyName: String?
    
    func configure(partyName: String?) {
        self.viewModel = PartyInviteViewModel()
        self.viewModel?.delegate = self
        self.partyName = partyName
        partyInviteMessage.text = Constant.defaultMessageText
        InvitationAnswerButtonContainer.isHidden = true
    }
    
    @IBAction func sharePartyButtonTapped(_ sender: Any) {
        broadcastInvite()
        partyShareButtonContainer.isHidden = true
    }
    
    @IBAction func joinPartyButtonTapped(_ sender: Any) {
        searchForParties()
        partyShareButtonContainer.isHidden = true
    }
    
    func removePartyService() {
        viewModel?.stopAcceptingInvites()
        viewModel?.stopBroadcastPartyInvite()
    }
    
    private func broadcastInvite() {
        guard let partyName = partyName else { return }
        viewModel?.broadcastPartyInvite(partyName: partyName)
        partyInviteMessage.text = Constant.broadcastPartyInviteMessage
        InvitationAnswerButtonContainer.isHidden = true
    }
    
    private func searchForParties() {
        partyInviteMessage.text = Constant.joinMessage
        viewModel?.beginAcceptingInvites()
    }
    
    private func displayPartyInvite(partyName: String) {
        let message = "Would you like to join \(partyName)?"
        InvitationAnswerButtonContainer.isHidden = false
        partyInviteMessage.text = message
    }
    
    @IBAction func declineInvitationButtonTapped(_ sender: Any) {
        delegate?.finishedWithPartyInviteView()
    }
    
    @IBAction func AcceptInvitationButtonTapped(_ sender: Any) {
        guard let partyName = self.partyName else { return }
        delegate?.didJoinParty(partyName: partyName)
        delegate?.finishedWithPartyInviteView()
    }
}

extension PartyInviteView: PartyInviteViewModelDelegate {
    func receivedInvite(partyName: String) {
        self.partyName = partyName
        displayPartyInvite(partyName: partyName)
    }
}


