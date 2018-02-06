import Foundation
import UIKit
import FirebaseDatabase

class HubViewModel {
    
    struct Constant {
        static let pathComponent = "characters.plist"
        static let playerKey = "players"
        static let scenarioKey = "scenario"
    }
    
    private var character: Character?
    private var characters: [Character]?
    private(set) var partyName: String
    private(set) var characterDatasource: ModelDatasource<Character>?
    
    var name: String {
        guard let char = character else { return "" }
        return char.name
    }
    
    var health: String {
        guard let char = character else { return "0" }
        return char.health
    }
    
    var characterClassCount: Int {
        return Character.classes.count
    }
    
    init() {
        //stubb
        partyName = "The Funk Hunters"
        
        let characterDataURL = URL.libraryFilePathWith(finalPathComponent: Constant.pathComponent)
        self.characterDatasource = ModelDatasource(with: characterDataURL)
        print(characterDataURL ?? "Could not print character.plist URL")
    }
    
    //MARK: - character methods
    func loadCharactersFromPList(){
        var characterList = [Character]()
        guard let characterCount = characterDatasource?.count() else { return }
        guard characterCount > 0 else { return }
        for i in stride(from: 0, to: characterCount, by: 1) {
            if let characterToAdd = characterDatasource?.modelAt(index: i) {
                characterList.append(characterToAdd)
            }
        }
        characters = characterList
    }
    
    func charactersForDisplay() -> [String] {
        var displayList = [String]()
        if let characters = characters {
            if characters.count > 0 {
                for i in stride(from: 0, to: characters.count, by: 1) {
                    let char = characters[i]
                    let imageString = characterImageforClass(characterClass: char.characterClass)
                    displayList.append(imageString)
                }
            }
        }
        let allCharactersCount = Character.classes.count
        for i in stride (from: 0, to: allCharactersCount, by: 1) {
            let imageString = characterImageforClass(characterClass: Character.classes[i])
            if displayList.contains(imageString) {}
            else {
                displayList.append(imageString)
            }
        }
        return displayList
    }
    
    func characterImageforClass(characterClass: CharacterClass) -> String {
        switch characterClass {
        case .cragheart:
            return "cragheartSymbol"
        case .brute:
            return "bruteSymbol"
        case .mindthief:
            return "mindthiefSymbol"
        case .scoundrel:
            return "scoundrelSymbol"
        case .spellweaver:
            return "spellweaverSymbol"
        case .tinkerer:
            return "tinkererSymbol"
        }
    }
    
//    func characterInfoForLabel() -> String {
//        guard let char = character else { return }
//        return
//    }
    
    func createCharacter(charClass: CharacterClass, name: String, experience: Int) {
        character = Character(characterClass: charClass, name: name)
        guard let char = character else { return }
        char.updateExperience(amount: experience)
        guard let intLevel = Int(char.level) else { return }
        let goldForLevel = 15 * (intLevel + 1)
        char.updateGold(amount: goldForLevel)
        characterDatasource?.update(model: char)
    }
    
    
}
