import Foundation

struct PhotosSearchResult: Codable {
    
    let photos: PhotoSearchResult
}


struct PhotoSearchResult: Codable {
    let page: UInt
    let pages: UInt
    
    let photos: [PhotoModel]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case pages
        case photos = "photo"
    }
    
}
