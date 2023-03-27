//
//  AccountView.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 26/02/2023.
//

import SwiftUI

struct AccountView: View {
    
    @State var isDeleted = false
    @State var isPinned = false
    @State var address: Address = Address(id: 1, country: "Canada")
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("isLiteMode") var isLiteMode = true
    @ObservedObject var coinModel = CoinModel()
    
    func fetchAddress() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/v2/addresses")!
            let (data, _) = try await URLSession.shared.data(from: url)
            address = try JSONDecoder().decode(Address.self, from: data)
        } catch {
            address = Address(id: 1, country: "Error fetching...")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                Section {
                    Toggle(isOn: $isLiteMode) {
                        Label("Lite Mode", systemImage: isLiteMode ? "hare" : "tortoise")
                    }
                }
                .foregroundColor(.primary)
                
                links
                
                coins
                
                Button {
                    isLogged = false
                    dismiss()
                } label: {
                    Text("Sign out")
                        .frame(maxWidth: .infinity)
                }
                .tint(.red)
            }
            .task {
                await fetchAddress()
                await coinModel.fetchCoins()
            }
            .refreshable {
                await fetchAddress()
                await coinModel.fetchCoins()
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(trailing: Button {
                dismiss()
            } label: { Text("Done") })
        }
    }
    
    //MARK: - Local Views
    
    var profile: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    HexagonView()
                        .offset(x: -50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x: 200, y: 0)
                        .scaleEffect(0.6)
                )
            Text("Meng To")
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text(address.country)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var menu: some View {
        Section {
            NavigationLink(destination: HomeView()) {
                Label("Settings", systemImage: "gear")
            }
            NavigationLink { Text("Billing") } label: {
                Label("Billing", systemImage: "creditcard")
            }
            NavigationLink { HomeView() } label: {
                Label("Help", systemImage: "questionmark")
            }
        }
        .foregroundColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    
    var links: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://apple.com")!) {
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    
                    Button(action: {
                        withAnimation {
                            isDeleted = true
                        }
                    }
                    ) { Label("Delete", systemImage: "trash") }
                        .tint(.red)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    pinButton
                }
            }
            Link(destination: URL(string: "https://youtube.com")!) {
                HStack {
                    Label("YouTube", systemImage: "tv")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
            .swipeActions {
                pinButton
            }
        }
        .foregroundColor(.primary)
        .listRowSeparator(.hidden)
        
    }
    
    var coins: some View {
        Section/*(header: Text("Coins"))*/ {
            ForEach(coinModel.coins) { coin in
                HStack {
//                    AsyncImage(url: URL(string: coin.logo), transaction: Transaction(animation: .easeOut)) { phase in
//                        switch phase {
//                        case .success(let image):
//                            image.resizable()
//                                .transition(.scale(scale: 0.5, anchor: .center))
//                        case .empty:
//                            ProgressView()
//                        case .failure(_):
//                            Color.gray
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }

                                        AsyncImage(url: URL(string: coin.logo)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            ProgressView()
                                        }
                    .frame(width: 32, height: 32)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.coin_name)
                        Text(coin.acronym)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
                    } header: {
                            Text("Coins")
        }
    }
    
    var pinButton: some View {
        Button { isPinned.toggle() } label: {
            if isPinned {
                Label("Unpin", systemImage: "pin.slash")
            } else {
                Label("Pin", systemImage: "pin")
            }
        }
        .tint(isPinned ? .gray : .yellow)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
