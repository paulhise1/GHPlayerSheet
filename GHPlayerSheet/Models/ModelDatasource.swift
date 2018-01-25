import Foundation

protocol ModelProtocol {
    func identifier() -> Date
}

class ModelDatasource<T: ModelProtocol> {
    
    private var models: [T]
    private let filePath: URL?
    
    init(with filePath: URL?) {
        self.filePath = filePath
        self.models = ModelDatasource.loadModels(from: filePath)
        print(filePath)
    }
    
    func remove(model: T) {
        models = models.filter() {
            return $0.identifier() != model.identifier()
        }
        saveModels()
    }
    
    func update(model: T) {
        remove(model: model)
        models.insert(model, at: 0)
        saveModels()
    }
    
    func modelAt(index: Int) -> T {
        return models[index]
    }
    
    func count() -> Int {
        return models.count
    }
    
    private func saveModels() {
        guard let url = filePath else { return }
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(models)
            try data.write(to: url)
        } catch {
            print("Error encoding models to \(url): \(error)")
        }
    }
    
    private static func loadModels(from url: URL?) -> [T] {
        guard let url = url, let data = try? Data(contentsOf: url) else {
            return [T]()
        }
        do {
            return try PropertyListDecoder().decode([T].self, from: data)
        } catch {
            return [T]()
        }
    }
}
