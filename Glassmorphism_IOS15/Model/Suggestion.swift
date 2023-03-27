//
//  Suggestion.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 04/03/2023.
//

import SwiftUI

struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestionsData = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "Flutter"),
    Suggestion(text: "Design"),
    Suggestion(text: "React")
]
