import Foundation

class CharactersDatasource {
    
    private var charactersList: [CharacterModel]
    
    init() {
        charactersList = CharactersDatasource.loadCharactersList()
        print(URL.charactersDataFilePath())
    }
    
    func updateCharacter(updatedCharacter: CharacterModel) {
        charactersList.append(updatedCharacter)
        saveCharactersList()
    }
    
    func getCharacter() -> CharacterModel {
        // need to figure out an id for which character in the list is needed.
        // right now serving up the one and only
        return charactersList[0]
        
    }
    
    private func saveCharactersList() {
        guard let url = URL.charactersDataFilePath() else {
            return
        }
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(charactersList)
            try data.write(to: url)
        } catch {
            print("Error encoding charactersList to characters.plist: \(error)")
        }
    }
    
    private static func loadCharactersList() -> [CharacterModel] {
        guard let url = URL.charactersDataFilePath(), let data = try? Data(contentsOf: url) else {
            return [CharacterModel]()
        }
        do {
            return try PropertyListDecoder().decode([CharacterModel].self, from: data)
        } catch {
            return [CharacterModel]()
        }
    }

    
}

extension URL {
    static func charactersDataFilePath() -> URL? {
        return (FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent("characters.plist"))
    }
}
