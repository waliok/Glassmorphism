//
//  PlaceholderExtension.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 14/03/2023.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote.weight(.semibold))
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(TitleModifier())
    }
}


extension View {
    func textPlaceholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        blendMode: BlendMode = .overlay,
        foregroundColor: Color = .primary,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

extension View {
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        blendMode: BlendMode = .overlay,
        foregroundColor: Color = .primary) -> some View {
            
            textPlaceholder(when: shouldShow, alignment: alignment, blendMode: blendMode, foregroundColor: foregroundColor) { Text(text).foregroundColor(foregroundColor).blendMode(blendMode)
            }
        }
}
