//
//  InputStyle.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 09/03/2023.
//

import SwiftUI

struct AddIcon: ViewModifier {
    var icon: String
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(15)
            .padding(.leading, 40)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .clipped()
            .overlay(
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .frame(width: 36, height: 36)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .clipped()
                    .outlineOverlay(cornerRadius: 14)
                    .shadow(color: color, radius: 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .animation(.easeOut, value: color))
    }
}

extension View {
    func addIcon(icon: String = "mail", color: Color = .teal) -> some View {
        modifier(AddIcon(icon: icon, color: color))
    }
}

