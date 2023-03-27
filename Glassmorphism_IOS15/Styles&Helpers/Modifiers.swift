//
//  Modifiers.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 15/03/2023.
//

import SwiftUI

//MARK: -  Stroke Style Modifiers

struct OutlineModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.1 : 0.3),
                            .black.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )
        )
    }
}

struct OutlineVerticalModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .linearGradient(
                        colors: [.black.opacity(0.2), .white.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .blendMode(.overlay)
        )
    }
}

struct OutlineOverlay: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .blendMode(.overlay)
        )
    }
}

extension View {
    func outlineModifier(cornerRadius: CGFloat = 20) -> some View {
        self.modifier(OutlineModifier(cornerRadius: cornerRadius))
    }
    
    func outlineVerticalModifier(cornerRadius: CGFloat = 20) -> some View {
        self.modifier(OutlineVerticalModifier(cornerRadius: cornerRadius))
    }
    
    func outlineOverlay(cornerRadius: CGFloat = 20) -> some View {
        self.modifier(OutlineOverlay(cornerRadius: cornerRadius))
    }
}

//MARK: - Background Modifiers

struct BackgroundColor: ViewModifier {
    var opacity: Double = 0.6
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Color("Background")
                    .opacity(colorScheme == .dark ? opacity : 0)
                    .blendMode(.overlay)
                    .allowsHitTesting(false)
            )
    }
}

extension View {
    func backgroundColor(opacity: Double = 0.6) -> some View {
        self.modifier(BackgroundColor(opacity: opacity))
    }
}

struct BackgroundStyle: ViewModifier {
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.6
    var withDarkBack: Bool = true
    @AppStorage("isLiteMode") var isLiteMode = true
    
    func body(content: Content) -> some View {
        if withDarkBack == false {
            content
                .cornerRadius(cornerRadius)
                .shadow(color: Color("Shadow").opacity(isLiteMode ? 0 : 0.3), radius: 20, x: 0, y: 10)
                .outlineOverlay(cornerRadius: cornerRadius)
        } else {
            content
                .backgroundColor(opacity: opacity)
                .cornerRadius(cornerRadius)
                .shadow(color: Color("Shadow").opacity(isLiteMode ? 0 : 0.3), radius: 20, x: 0, y: 10)
                .outlineOverlay(cornerRadius: cornerRadius)
        }
    }
}

extension View {
    func backgroundStyle(cornerRadius: CGFloat = 20, opacity: Double = 0.6, withDarkBack: Bool = true) -> some View {
        self.modifier(BackgroundStyle(cornerRadius: cornerRadius, opacity: opacity, withDarkBack: withDarkBack))
    }
}

//MARK: - Animation Slide - Fade Effect Modifier

struct SlideFadeIn: ViewModifier {
    var show: Bool
    var offset: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(show ? 1 : 0)
            .offset(y: show ? 0 : offset)
    }
}

extension View {
    func slideFadeIn(show: Bool, offset: Double = 10) -> some View {
        self.modifier(SlideFadeIn(show: show, offset: offset))
    }
}


