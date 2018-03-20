import UIKit

protocol PartyInviteViewDelegate: class {
    func didJoinParty(partyName: String)
    func finishedWithPartyInviteView()
}

class PartyInviteView: UIView {
    
    struct Constant {
        static let broadcastPartyInviteMessage = "Broadcasting Party Invite"
        static let joinMessage = "Searching For Party Invite From Nearby"
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
        InvitationAnswerButtonContainer.isHidden = true
        if partyName != nil {
            self.partyName = partyName
            partyInviteMessage.text = Constant.defaultMessageText
        } else if partyName == nil {
            searchForParties()
            partyShareButtonContainer.isHidden = true
        }
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
        partyInviteMessage.text = "\(Constant.broadcastPartyInviteMessage)\n\n Party: \(partyName)"
        partyInviteMessage.textColor = UIColor.flatWatermelon()
        InvitationAnswerButtonContainer.isHidden = true
    }
    
    private func searchForParties() {
        partyInviteMessage.textColor = UIColor.flatMint()
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


