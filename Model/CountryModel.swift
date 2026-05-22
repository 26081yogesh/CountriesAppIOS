import Foundation

struct CountryModel: Codable, Hashable {
    let name: String
    let capital: String?
    let region: String
    let currencies: [Currency]?
    let flags: Flag?
}

struct Flag: Codable, Hashable {
    let flagImage: String?

    enum CodingKeys: String, CodingKey {
        case flagImage = "png"
    }
}

struct Currency: Codable, Hashable {
    let name: String?
    let symbol: String?
}
