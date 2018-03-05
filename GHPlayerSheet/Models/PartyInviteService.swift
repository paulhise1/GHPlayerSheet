import Foundation

protocol PartyInviteService {
    weak var delegate: PartyInviteServiceDelegate? {get set}
    func advertisePartyName(partyName: String)
    func browseForPartyInvite()
    func stopAdvertisingParty()
    func stopAcceptingInvites()
}

protocol PartyInviteServiceDelegate: class {
    func didFindPartyToJoin(partyName: String)
    
}

