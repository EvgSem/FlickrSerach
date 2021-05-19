import Foundation

struct PhotoModel: Codable {
    let id: String
    let farm: Int
    let secret: String
    let server: String
    let url: String?
    
    var pictureUrl: NSURL  {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case secret
        case server
        case farm
        case url = "url_s"
    }
}
