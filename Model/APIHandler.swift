
import Foundation

@Observable
class APIHandler {
    let urlString: String = "https://www.apicountries.com/countries"

    func getCountry() async throws -> [CountryModel] {
        guard let url = URL(string: urlString) else {
            throw ErrorsEnum.badUrlString
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw ErrorsEnum.invalidResponse(responseCode: code)
        }

        let decoder = JSONDecoder()
        return try decoder.decode([CountryModel].self, from: data)
    }
}
