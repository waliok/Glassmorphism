//
//  FeaturedItem.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 27/02/2023.
//

import SwiftUI

struct FeaturedItem: View {
    var course: Course
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            LogoView(image: course.logo)
            Text(course.title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(course.subtitle.uppercased())
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(course.text)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(sizeCategory > .large ? 1 : 2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .frame(maxWidth: 500)
        .frame(height: 350)
        .background(.ultraThinMaterial)
        .backgroundColor(opacity: 0.5)
        .cornerRadius(30)
        .modifier(OutlineModifier(cornerRadius: 30))
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeaturedItem(course: courses[0])
            FeaturedItem(course: courses[0])
                .environment(\.sizeCategory, .accessibilityLarge)
        }
    }
}
