//
//  Glassmorphism_IOS15App.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 26/02/2023.
//

import SwiftUI

@main
struct Glassmorphism_IOS15App: App {
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(model)
        }
    }
}
