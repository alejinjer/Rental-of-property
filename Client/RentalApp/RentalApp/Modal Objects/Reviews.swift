import Foundation

struct Review: Decodable {
    let id: Int
    let username: String
    let apartmentId: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case apartmentId
        case text
    }
}

