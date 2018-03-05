import Foundation

protocol PartyInviteViewModelDelegate: class {
//    func receivedInviteConfirmation(message: String)
//    func receivedPartyInvite(partyName: String, message: String)
    func receivedInvite(partyName: String)
}

class PartyInviteViewModel {
    
    weak var delegate: PartyInviteViewModelDelegate?
    private var service: PartyInviteService
    
    init() {
        self.service = MPCPartyInviteService()
        service.delegate = self
    }
    
    func broadcastPartyInvite(partyName: String) {
        service.advertisePartyName(partyName: partyName)
    }
    
    func beginAcceptingInvites() {
        service.browseForPartyInvite()
    }
    
    func stopAcceptingInvites() {
        service.stopAcceptingInvites()
    }
    
    func stopBroadcastPartyInvite() {
        service.stopAdvertisingParty()
    }
}

extension PartyInviteViewModel: PartyInviteServiceDelegate {
    func didFindPartyToJoin(partyName: String) {
        delegate?.receivedInvite(partyName: partyName)
    }
}
