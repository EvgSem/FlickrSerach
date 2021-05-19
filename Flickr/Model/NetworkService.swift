import Foundation


class NetworkService {
    
    private let searchUrlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=675894853ae8ec6c242fa4c077bcf4a0&extras=url_s&format=json&nojsoncallback=1"
    private let urlSession = URLSession.shared
    
    
    func fetchPictures(searchText: String, page: Int, completion: @escaping(Result<PhotoSearchResult>) -> Void){
        
        guard var urlComponents = URLComponents(string: searchUrlString) else {
            completion(.error("Wrong url: \(searchUrlString)"))
            return
        }
        
        let textQuery = URLQueryItem(name: "text", value: searchText)
        let pageQuery = URLQueryItem(name: "page", value: String(page))
        
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + [textQuery, pageQuery]
         
         guard let searchUrl = urlComponents.url else {
            completion(.error("Wrong url: \(urlComponents.debugDescription)"))
             return
         }
        
        let task = urlSession.dataTask(with: URLRequest(url: searchUrl as URL)) { data, response, error in
            let response = self.handleResponse(data, response, error)
            
            guard case .success(let data) = response else {
                
                if case .error(let description) = response {
                    completion(.error(description))
                } else {
                    fatalError()
                }
                return
            }
            
            _ = try! JSONDecoder().decode(PhotosSearchResult.self, from: data)
            guard let result = try? JSONDecoder().decode(PhotosSearchResult.self, from: data) else {

                completion(.error("Failed to decode from JSON"))
                return
            }

            completion(.success(result.photos))
        }
        task.resume()
    }
    
    private func handleResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<Data> {
        
        if let error = error {
            return .error(error.localizedDescription)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .error("Not HTTP Response")
        }
        
        guard response.statusCode == 200 else {
            return .error("HTTP code: \(response.statusCode)")
        }
        
        guard let data = data else {
            return .error("No data returned")
        }
        
        return .success(data)
    }
}

