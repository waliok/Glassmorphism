//
//  DisMissExtentsion.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 14/03/2023.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
