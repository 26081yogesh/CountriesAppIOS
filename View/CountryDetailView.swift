import SwiftUI

struct CountryDetailView: View {
    var country: CountryModel?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                if let flagString = country?.flags?.flagImage, let url = URL(string: flagString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.secondary.opacity(0.1))
                            .frame(height: 220)
                            .overlay(ProgressView())
                    }
                    .padding(.horizontal)
                } else {
                    ContentUnavailableView("No Flag Available", systemImage: "flag.slash")
                        .frame(height: 220)
                }
                
                VStack(spacing: 4) {
                    Text(country?.name ?? "Unknown Country")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                    
                    if let region = country?.region {
                        Text(region.uppercased())
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 16) {
                    
                    InfoCardView(title: "Geography", systemImage: "globe.americas.fill") {
                        InfoRow(label: "Capital", value: country?.capital ?? "No Capital")
                        Divider()
                        InfoRow(label: "Region", value: country?.region ?? "N/A")
                    }
                    
                    if let currencies = country?.currencies, !currencies.isEmpty {
                        InfoCardView(title: "Currency", systemImage: "banknote.fill") {
                            ForEach(currencies, id: \.name) { currency in
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(currency.name ?? "Unknown Currency")
                                            .font(.body)
                                            .fontWeight(.medium)
                                    }
                                    Spacer()
                                    if let symbol = currency.symbol {
                                        Text(symbol)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .padding(8)
                                            .background(Color.accentColor.opacity(0.1), in: .circle)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct InfoCardView<Content: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: systemImage)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading, spacing: 12) {
                content()
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}


#Preview {
    NavigationStack {
        CountryDetailView(
            country: CountryModel(
                name: "India",
                capital: "New Delhi",
                region: "Asia",
                currencies: [Currency(name: "Indian Rupee", symbol: "₹")],
                flags: Flag(flagImage: "https://flagcdn.com/w320/in.png")
            )
        )
    }
}
