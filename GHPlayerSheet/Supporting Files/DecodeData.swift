import Foundation

class DecodeData {
    
    func loadPListData(URLFilePath: URL?) -> [Any] {
        guard let url = URLFilePath, let data = try? Data(contentsOf: url) else {
            return []
        }
        do {
            return try PropertyListDecoder().decode([Any].self, from: data)
        } catch {
            return []
        }
    }


}
