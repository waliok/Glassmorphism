//
//  FieldReader.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 19/03/2023.
//

import SwiftUI

struct FieldReader: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY + 32)
                }
            }
    }
}

extension View {
    func addGeometryReader() -> some View {
        modifier(FieldReader())
    }
}


