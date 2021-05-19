import Foundation


class PhotoService {
    
    private let cache = NSCache<AnyObject, AnyObject>()
    private let networkService: NetworkService
    
    init() {
        networkService = NetworkService()
    }
    
    
    func search(for term: String, page: Int, completion: @escaping(Result<PhotoSearchResult>)->Void) {
        
        let term = term.lowercased().trimmingCharacters(in: .whitespaces)
        
        if let result = getFromCache(for: "\(term)\(page)") as PhotoSearchResult? {
            completion(.success(result))
            return
        }
        
        networkService.fetchPictures(searchText: term, page: page) {
            if case .success(let result) = $0 {
                self.saveToCache(item: result, for: "\(term)\(page)")
            }
            
            completion($0)
        }
        
    }
    
    private func getFromCache<T>(for key: String) -> T? {
        
        if let result = cache.object(forKey: key as AnyObject) as? T {
            
            return result
        }
        
        return nil
    }
    
    private func saveToCache<T>(item: T, for key: String) {
        self.cache.setObject(item as AnyObject, forKey: key as AnyObject)
    }
}
