import Foundation
import UIKit
import FirebaseDatabase

class HubViewModel {
    
    struct Constant {

    }
    
    private(set) var party: String
    private(set) var characterDatasource: ModelDatasource<Character>?

    init() {
        //stubb
        party = "The Funk Hunters"
        
        
    }

}
