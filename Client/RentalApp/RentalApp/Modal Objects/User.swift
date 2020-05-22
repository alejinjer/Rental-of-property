import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let surname: String
    let username: String
    let email: String
    let phone: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case username
        case email
        case phone
        case password
    }
}

