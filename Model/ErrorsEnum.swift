

import Foundation

enum ErrorsEnum: Error {
    case badUrlString
    case invalidResponse(responseCode: Int)
    case fetchCountriesFailed

    var error: String {
        switch self {
        case .badUrlString:
            return "ERROR: APIHandler.swift -> Bad URL String"

        case let .invalidResponse(responseCode: responseCode):
            return "ERROR: Invalid Response Code - \(responseCode)"

        case .fetchCountriesFailed:
            return "ERROR: Fetch Countries Failed in CountriesViewModel.swift"
        }
    }
}
