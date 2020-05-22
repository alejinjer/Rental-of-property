import Foundation

struct Apartment: Decodable {
    let id: Int
    let flatsNumber: Int
    let cost: Int
    let description: String
    let address: String
    let imgUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case flatsNumber = "flats_number"
        case cost
        case description
        case address
        case imgUrl = "img_url"
    }
}

