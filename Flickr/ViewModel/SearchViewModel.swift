import Foundation


class SearchViewModel {
    var photoModels: [PhotoModel] = []
    private var currentPage = 1
    private let photoService: PhotoService
    
    init(){
        photoService = PhotoService()
    }
    
    func loadPictures(searchText: String, completion: @escaping(Result<Void>)->()) {
        photoService.search(for: searchText, page: currentPage) { [weak self] result in
                switch result {
                    
                case .success(let searchResult):
                    self?.currentPage += 1
                    self?.handle(result: searchResult)
                    completion(.success(()))
                    
                case .error(let description):
                    completion(.error(description))
                }
                
        }
    }
    
    private func handle(result: PhotoSearchResult) {
        photoModels = result.photos
    }
}
