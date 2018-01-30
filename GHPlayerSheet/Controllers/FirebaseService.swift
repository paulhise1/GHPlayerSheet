import Foundation
import FirebaseDatabase

class FirebaseService: ScenarioService {
    weak var delegate: ScenarioServiceDelegate?

    private var database: DatabaseReference!

    init() {
        database = Database.database().reference()
//        configureFirebaseListener()
    }
    
    func pushPlayerToService(player: Player) {
        // we want to update this player on firebase
    }
    
//    func configureFirebaseListener(){
//        let playerRef = database.child(partyName).child(Constant.playerKey)
//        playerRef.observe(.value, with: { (snapshot) in
//            if let playerDictFromFirebase = snapshot.value as? [String: Any] {
//                for (player, stats) in playerDictFromFirebase {
//                    print(player)
//                    if let statsDict = stats as? [String: Int] {
//                        print(statsDict["health"])
//                    }
//                }
//                print(playerDictFromFirebase)
//            }
//        })
//    }

}
