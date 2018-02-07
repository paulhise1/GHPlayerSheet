import Foundation
import UIKit
import FirebaseDatabase

class HubViewModel {
    
    struct Constant {
        static let characterPathComponent = "characters.plist"
        static let classPathComponent = "characterClasses.plist"
        static let playerKey = "players"
        static let scenarioKey = "scenario"
    }
    
    private var character: Character?
    private var characters: [Character]?
    private(set) var partyName: String
    private(set) var characterDatasource: ModelDatasource<Character>?
    private(set) var classesDatasource: ModelDatasource<CharacterClass>?
    
    var name: String {
        guard let char = character else { return "" }
        return char.name
    }
    
    var health: String {
        guard let char = character else { return "0" }
        return char.health
    }
    
    var characterClassCount: Int {
        return CharacterClass.classes.count
    }
    
    init() {
        //stubb
        partyName = "The Funk Hunters"
        
        let characterDataURL = URL.libraryFilePathWith(finalPathComponent: Constant.characterPathComponent)
        self.characterDatasource = ModelDatasource(with: characterDataURL)
        print(characterDataURL ?? "Could not print character.plist URL")
        
        let charClassDataURL = URL.libraryFilePathWith(finalPathComponent: Constant.classPathComponent)
        self.classesDatasource = ModelDatasource(with: charClassDataURL)
        createUnlockedClassesList()
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
    
    func unlockCharacterClass(charClass: CharacterClass.charClass) {
        let classUnlocking = CharacterClass(classOf: charClass, unlocked: true, owned: false)
        classesDatasource?.update(model: classUnlocking)
    }
    
    func createUnlockedClassesList(){
        guard let classesCount = classesDatasource?.count() else { return }
        if classesCount == 0 {
            unlockCharacterClass(charClass: .brute)
            unlockCharacterClass(charClass: .mindthief)
            unlockCharacterClass(charClass: .cragheart)
            // need other 3 starting classes
        }
    }
    
    func unlockedCharsForDisplay() -> [CharacterClass.charClass] {
        //Owned appended first
        var unlockedChars = [CharacterClass.charClass]()
        if let characters = characters {
            if characters.count > 0 {
                for i in stride(from: 0, to: characters.count, by: 1) {
                    let char = characters[i].characterClass
                    unlockedChars.append(char)
                }
            }
        }
        //unlocked appended second
        if let unlockedCount = classesDatasource?.count() {
            for i in stride (from: 0, to: unlockedCount, by: 1) {
                if let charClass = classesDatasource?.modelAt(index: i).classOf {
                    //                    let imageString = CharacterClass.characterImageForClass(charClass: charClass)
                    if unlockedChars.contains(charClass) {
                    } else {
                        unlockedChars.append(charClass)
                    }
                }
            }
        }
        return unlockedChars
    }
    
    func allCharsForDisplay() -> [String] {
        var displayImageStrings = [String]()
        let list1 = unlockedCharsForDisplay()
        var list2 = [CharacterClass.charClass]()
        for i in list1 {
            displayImageStrings.append(CharacterClass.characterImageForClass(charClass: i))
        }
        let allCharactersCount = CharacterClass.classes.count
        for i in stride (from: 0, to: allCharactersCount, by: 1) {
            if list1.contains(CharacterClass.classes[i]) {
            } else {
                list2.append(CharacterClass.classes[i])
            }
        }
        for i in list2 {
            displayImageStrings.append(CharacterClass.characterSymbolImageForClass(charClass: i))
        }
        return displayImageStrings
    }
    
    
    func createCharacter(charClass: CharacterClass.charClass, name: String, experience: Int) {
        character = Character(characterClass: charClass, name: name)
        guard let char = character else { return }
        char.updateExperience(amount: experience)
        guard let intLevel = Int(char.level) else { return }
        let goldForLevel = 15 * (intLevel + 1)
        char.updateGold(amount: goldForLevel)
        characterDatasource?.update(model: char)
    }
    
    
}
