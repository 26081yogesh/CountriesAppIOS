import SwiftUI

struct MainListView: View {
    @State private var viewModel = CountriesViewModel()
    @State private var searchText = ""
    
    var filteredCountries: [CountryModel] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("Exploring the globe...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } else if viewModel.countries.isEmpty {
                    ContentUnavailableView("No Countries Found",
                                           systemImage: "globe.desk",
                                           description: Text("Please check your internet connection and try again."))
                } else {
                    List(filteredCountries, id: \.name) { country in
                        NavigationLink(value: country) {
                            HStack(spacing: 16) {
                                
                                if let flagString = country.flags?.flagImage, let url = URL(string: flagString) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.secondary.opacity(0.1)
                                    }
                                    .frame(width: 44, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                                    )
                                } else {
                                    Image(systemName: "flag.fill")
                                        .foregroundStyle(.secondary)
                                        .frame(width: 44, height: 30)
                                        .background(Color.secondary.opacity(0.1), in: .rect(cornerRadius: 6))
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(country.name)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.primary)
                                    
                                    Text(country.capital ?? "No Capital Specified")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Text(country.region)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.primary.opacity(0.05), in: .capsule)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Countries")
            .searchable(text: $searchText, prompt: "Search countries")
            .navigationDestination(for: CountryModel.self) { country in
                CountryDetailView(country: country)
            }
            .task {
                await viewModel.fetchCountries()
            }
            .refreshable {
                await viewModel.fetchCountries()
            }
        }
    }
}
