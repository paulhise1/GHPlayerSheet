import Foundation
import MultipeerConnectivity

class MPCManager: NSObject {
    
    let peerID: MCPeerID
    let session: MCSession
    
    lazy var advertiser: MCNearbyServiceAdvertiser = {
        return MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: ["Party Name": "FunkHunters"], serviceType: "supsupsup")
    }()
    lazy var browser: MCNearbyServiceBrowser = {
        return MCNearbyServiceBrowser(peer: peerID, serviceType: "supsupsup")
    }()
    
    override init() {
        peerID = MCPeerID(displayName: "asdf")
        session = MCSession(peer: peerID)
    }
    
    func beginAdvertising() {
        advertiser.delegate = self
        advertiser.startAdvertisingPeer()
        print("Did begin advertising")
    }
    
    func beginBrowsing() {
        browser.delegate = self
        browser.startBrowsingForPeers()
        print("Did begin browsing")
    }
}

extension MPCManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("Did receive Invitation from peer \(peerID) ---  with Context \(String(describing: context))")
    }
}

extension MPCManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("foundPeer - \(peerID), withDiscoveryInfo - \(String(describing: info))")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("lost peer \(peerID)")
    }
}

extension MPCManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {    }
    
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {    }
}
