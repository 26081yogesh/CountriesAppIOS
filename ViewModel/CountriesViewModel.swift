import Foundation

@Observable
class CountriesViewModel {
    private let apiHandler = APIHandler()

    var isLoading: Bool = true
    var countries: [CountryModel] = []

    func fetchCountries() async {
        do {
            countries = try await apiHandler.getCountry()
            isLoading = false
        } catch {
            print("ERROR -> \(error)")
        }
    }
}
