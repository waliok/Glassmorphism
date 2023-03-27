//
//  Coin.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 20/03/2023.
//

import Foundation

struct CryptoCoin: Identifiable, Decodable {
    var id: Int
    var coin_name: String
    var acronym: String
    var logo: String
}

class CoinModel: ObservableObject {
    @Published var coins: [CryptoCoin] = []
    
    @MainActor
    func fetchCoins() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10")!
            let (data, _) = try await URLSession.shared.data(from: url)
            coins = try JSONDecoder().decode([CryptoCoin].self, from: data)
        } catch {
            print("Error")
        }
    }
}
