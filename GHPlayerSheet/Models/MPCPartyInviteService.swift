import Foundation
import MultipeerConnectivity

class MPCPartyInviteService: NSObject {
    
    struct Constant {
        static let partyShareServiceType = "ghpartyshare"
        static let partyInvite = "partyInvite"
        static let inviteConfirmation = "inviteConfirmation"
        static let advertiseDiscoveryInfo = "partyName"
    }
    
    weak var delegate: PartyInviteServiceDelegate?
    
    private let partyShareServiceType = Constant.partyShareServiceType
    
    private let myPeerId: MCPeerID
    private let session: MCSession
    private var serviceAdvertiser: MCNearbyServiceAdvertiser?
    private var serviceBrowser: MCNearbyServiceBrowser?
    
    override init() {
        myPeerId = MCPeerID(displayName: UIDevice.current.name)
        session =  MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        super.init()
        session.delegate = self
    }
    
    deinit {
        self.serviceAdvertiser?.stopAdvertisingPeer()
        self.serviceBrowser?.stopBrowsingForPeers()
    }
    
    private func advertiseToBrowsers(partyName: String) {
        print("peer advertising To Browsers")
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: [Constant.advertiseDiscoveryInfo: partyName], serviceType: partyShareServiceType)
        self.serviceAdvertiser?.delegate = self
        self.serviceAdvertiser?.startAdvertisingPeer()
    }
    
    private func browseForPeers() {
        print("browsing for peers")
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: partyShareServiceType)
        self.serviceBrowser?.delegate = self
        self.serviceBrowser?.startBrowsingForPeers()
    }
}

extension MPCPartyInviteService: PartyInviteService {
    func advertisePartyName(partyName: String) {
        advertiseToBrowsers(partyName: partyName)
    }
    
    func browseForPartyInvite() {
        browseForPeers()
    }
    
    func stopAdvertisingParty() {
        self.serviceAdvertiser?.stopAdvertisingPeer()
    }
    
    func stopAcceptingInvites() {
        self.serviceBrowser?.stopBrowsingForPeers()
    }
}

extension MPCPartyInviteService: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("peer \(peerID) didChangeState: \(state.rawValue)")
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    }
}

extension MPCPartyInviteService: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    }
}

extension MPCPartyInviteService: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        //print("DiscoveryInfo: \(info)")
        guard let info = info, let partyName = info[Constant.advertiseDiscoveryInfo] else { return }
        delegate?.didFindPartyToJoin(partyName: partyName)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        print("lost peer: \(peerID)")
    }
}

// Unused but required delegate methods
extension MPCPartyInviteService {
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("didReceiveStream: \(streamName)")
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("didStartReceivingResourceWithName: \(resourceName)")
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("didFinishReceivingResourceWithName \(resourceName)")
    }

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("didNotStartAdvertisingPeer: \(error)")
    }

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("didNotStartBrowsingForPeers: \(error)")
    }
}

