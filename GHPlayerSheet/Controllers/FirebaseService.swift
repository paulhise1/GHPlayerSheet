import Foundation
import FirebaseDatabase

class FirebaseService: ScenarioService {
    
    struct Constant {
        static let playerKey = "players"
    }
    
    weak var delegate: ScenarioServiceDelegate?

    private var database: DatabaseReference!
    
    private var players: [Player]
    
    //stubbed properties
    //let partyName = "Harlem Globe Trotters"
    let partyName = "The Funk Hunters"
    
    
    init() {
        players = [Player]()
    
        database = Database.database().reference()
        configureFirebaseListener()
    }
    
    func pushPlayerToService(player: Player) {
        let playerName = player.name
        let playerInfo = ["health": player.health, "experience": player.experience, "maxHealth": player.maxHealth]
        database.child(partyName).child(Constant.playerKey).child(playerName).setValue(playerInfo)
    }
    
    
    func configureFirebaseListener(){
        let playerRef = database.child(partyName).child(Constant.playerKey)
        playerRef.observe(.value, with: { (snapshot) in
            if let playerDictFromFirebase = snapshot.value as? [String: [String: String]] {
                self.players = [Player]()
                for (player, stats) in playerDictFromFirebase {
                    self.players.append(Player(name: player, experience: stats["experience"]!, health: stats["health"]!, maxHealth: stats["maxHealth"]!))
                }
            }
            self.delegate?.didUpdatePlayers(players: self.players)
            print("******* players list from FirebaseService: \(self.players) *********")
        })
    }
    
}
