import Foundation

class EncodeData {

    func savePListData(URLFilePath: URL?, dataToEncode: [Any]) {
        guard let url = URLFilePath else {
            print("Error with the URL file path to save the data")
            return
        }
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(dataToEncode)
            try data.write(to: url)
        } catch {
            print("Error encoding \(dataToEncode): \(error)")
        }
    }
}


