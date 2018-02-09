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
    
    private(set) var partyName: String
    private(set) var characterDatasource: ModelDatasource<Character>?
    private(set) var classesDatasource: ModelDatasource<CharacterClass>?

    init() {
        //stubb
        partyName = "The Funk Hunters"
        
        let characterDataURL = URL.libraryFilePathWith(finalPathComponent: Constant.characterPathComponent)
        self.characterDatasource = ModelDatasource(with: characterDataURL)
        print(characterDataURL ?? "Could not print character.plist URL")
        
        let charClassDataURL = URL.libraryFilePathWith(finalPathComponent: Constant.classPathComponent)
        self.classesDatasource = ModelDatasource(with: charClassDataURL)
        
        createClassesList()
    }
  
    func unlockCharacterClass(charClass: CharacterClass) {
        charClass.unlocked = true
        classesDatasource?.update(model: charClass)
    }
    
    private func createClassesList(){
        guard let classesCount = classesDatasource?.count() else { return }
        //first time building list
        if classesCount == 0 {
            for i in CharacterClass.startingClasses {
                let startingClass = CharacterClass(classOf: i, unlocked: true, owned: false)
                classesDatasource?.update(model: startingClass)
            }
            for i in CharacterClass.unlockableClasses {
                let lockedClass = CharacterClass(classOf: i, unlocked: false, owned: false)
                classesDatasource?.update(model: lockedClass)
            }
        }
    }
    
    func infoForCharacter(character: Character) -> [String]{
        let charSymbol = CharacterClass.characterSymbolForClass(charClass: character.characterClass)
        return [character.name, character.level, charSymbol]
    }
    
    func classImages() -> [String] {
        let classesFromPList = loadClasses()
        let orderedClasses = orderClassesForDisplay(classesList: classesFromPList)
        return classesToStringForImage(Classes: orderedClasses)
    }
    
    func classesList() -> [CharacterClass] {
        let classesFromPList = loadClasses()
        return orderClassesForDisplay(classesList: classesFromPList)
    }
    
    private func loadClasses() -> [CharacterClass] {
        var classesList = [CharacterClass]()
        if let classesCount = classesDatasource?.count() {
            for i in stride(from: 0, to: classesCount, by: 1) {
                if let classesToAdd = classesDatasource?.modelAt(index: i) {
                    classesList.append(classesToAdd)
                }
            }
        }
        return classesList
    }
    
    private func orderClassesForDisplay(classesList: [CharacterClass]) -> [CharacterClass] {
        var orderedDisplayClasses = [CharacterClass]()
        for c in classesList {
            if c.owned == true {
                orderedDisplayClasses.append(c)
            }
        }
        for c in classesList {
            if c.unlocked == true && c.owned == false {
                orderedDisplayClasses.append(c)
            }
        }
        for c in classesList {
            if c.unlocked == false {
                orderedDisplayClasses.append(c)
            }
        }
        return orderedDisplayClasses
    }
    
    private func classesToStringForImage(Classes: [CharacterClass]) -> [String] {
        var classesString = [String]()
        for c in Classes {
            if c.owned {
                classesString.append(CharacterClass.characterOwnedImageForClass(charClass: c.classOf))
            } else if c.unlocked && !c.owned {
                classesString.append(CharacterClass.characterUnlockedImageForClass(charClass: c.classOf))
            } else {
                classesString.append(CharacterClass.characterSymbolForClass(charClass: c.classOf))
            }
        }
        return classesString
    }
    
    func createCharacter(charClass: CharacterClass.charClass, name: String, experience: Int) {
        let character = Character(characterClass: charClass, name: name)
        character.updateExperience(amount: experience)
        characterDatasource?.update(model: character)
        if let classesDatasource = classesDatasource {
            let classesCount = classesDatasource.count()
            for i in stride(from: 0, to: classesCount, by: 1) {
                if character.characterClass == classesDatasource.modelAt(index: i).classOf {
                    let charClass = classesDatasource.modelAt(index: i)
                    charClass.owned = true
                    classesDatasource.update(model: charClass)
                }
            }
        }
    }
    
    
}
