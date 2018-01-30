//import Foundation
//import MultipeerConnectivity
//
//protocol ScenarioShareManagerDelegate {
//    func deviceConnectionDidChange(state: MCSessionState, displayName: String, peers: [MCPeerID])
//    func didReceiveNewStat(type: StatUpdateType, displayName: String)
//    func didRecieveInvitationFromPeer(displayName: String, maxHealth: String)
//}
//
//class ScenarioShareManager: NSObject {
//    
//    private let scenarioShareServiceType = MPCConstants.mPCServicType
//    
//    private let myPeerId: MCPeerID
//    private let maxHealth: String
//    private let serviceAdvertiser: MCNearbyServiceAdvertiser
//    private let serviceBrowser: MCNearbyServiceBrowser
//    var delegate: ScenarioShareManagerDelegate?
//    
//    init(displayName: String, maxHealth: String) {
//        self.myPeerId = MCPeerID(displayName: displayName)
//        self.maxHealth = maxHealth
//        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: scenarioShareServiceType)
//        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: scenarioShareServiceType)
//        
//        super.init()
//        
//        self.serviceAdvertiser.delegate = self
//        self.serviceAdvertiser.startAdvertisingPeer()
//    
//        self.serviceBrowser.delegate = self
//        self.serviceBrowser.startBrowsingForPeers()
//    }
//    
//    deinit {
//        self.serviceAdvertiser.stopAdvertisingPeer()
//        self.serviceBrowser.stopBrowsingForPeers()
//    }
//    
//    lazy var session : MCSession = {
//        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .none)
//        session.delegate = self
//        return session
//    }()
//
//    func broadcastStatUpdate(statType: String, value: String) {
//        print("sendStat: \(statType) to \(session.connectedPeers.count) peers")
//        
//        if session.connectedPeers.count > 0 {
//            do {
//                let data = NSKeyedArchiver.archivedData(withRootObject: [MPCConstants.statTypeKey: statType, MPCConstants.valueKey: value])
//                try self.session.send(data, toPeers: session.connectedPeers, with: .reliable)
//            }
//            catch let error {
//                print("Error for sending: \(error)")
//            }
//        }
//    }
//}
//
//
//extension ScenarioShareManager: MCSessionDelegate {
//    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//        print("peer \(peerID) didChangeState: \(state)")
//        self.delegate?.deviceConnectionDidChange(state: state, displayName: peerID.displayName, peers: session.connectedPeers)
//    }
//    
//    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        if let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? Dictionary<String, String>, let statString = dictionary[MPCConstants.statTypeKey], let value = dictionary[MPCConstants.valueKey] {
//            var statType: StatUpdateType
//            switch statString {
//            case MPCConstants.healthStatType:
//                statType = StatUpdateType.health(value)
//            case MPCConstants.experienceStatType:
//                statType = StatUpdateType.experience(value)
//            case MPCConstants.nameStatType:
//                statType = StatUpdateType.name(value)
//            default:
//                return
//            }
//            self.delegate?.didReceiveNewStat(type: statType, displayName: peerID.displayName)
//        }
//    }
//}
//
//extension ScenarioShareManager: MCNearbyServiceAdvertiserDelegate {
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        print("didReceiveInvitationFromPeer \(peerID)")
//        if let data = context, let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? Dictionary<String, String>, let maxHealth = dictionary[MPCConstants.maxHealth] {
//            
//            delegate?.didRecieveInvitationFromPeer(displayName: peerID.displayName, maxHealth: maxHealth)
//            
//            invitationHandler(true, self.session)
//        }
//    }
//}
//
//extension ScenarioShareManager: MCNearbyServiceBrowserDelegate {
//    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//        print("found peer: \(peerID) \ninvite peer: \(peerID)")
//        
//        let data = NSKeyedArchiver.archivedData(withRootObject: [MPCConstants.maxHealth: maxHealth])
//        browser.invitePeer(peerID, to: self.session, withContext: data, timeout: 10)
//    }
//    
//    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        print("lost peer: \(peerID)")
//    }
//}
//
//// Unused but required delegate methods
//extension ScenarioShareManager {
//    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
//        print("didReceiveStream: \(streamName)")
//    }
//    
//    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
//        print("didStartReceivingResourceWithName: \(resourceName)")
//    }
//    
//    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
//        print("didFinishReceivingResourceWithName \(resourceName)")
//    }
//    
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
//        print("didNotStartAdvertisingPeer: \(error)")
//    }
//    
//    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
//        print("didNotStartBrowsingForPeers: \(error)")
//    }
//}
//
//
//
//
//
