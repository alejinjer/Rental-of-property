import Foundation

struct Booking: Decodable {
    let id: Int
    let userId: Int
    let apartmentId: Int
    let dateFrom: String
    let dateTo: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case apartmentId
        case dateFrom = "date_from"
        case dateTo = "date_to"
    }
}

