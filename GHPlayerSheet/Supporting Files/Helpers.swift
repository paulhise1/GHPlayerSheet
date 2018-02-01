import Foundation

extension Date {
    static func dateToStringFormater(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/DD"
        let dateAsString = formatter.string(from: Date())
        return dateAsString
    }
}

extension URL {
    static func libraryFilePathWith(finalPathComponent:String) -> URL? {
        return (FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent(finalPathComponent))
    }
}


