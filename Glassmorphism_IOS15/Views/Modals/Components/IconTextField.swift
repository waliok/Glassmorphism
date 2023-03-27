//
//  IconTextField.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 15/03/2023.
//

import SwiftUI

struct IconTextField: View {
    var icon: String
    var color: Color
    
    var body: some View {
        
        Image(systemName: icon)
            .foregroundStyle(color)
            .frame(width: 36, height: 36)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            .clipped()
            .modifier(OutlineOverlay(cornerRadius: 14))
            .shadow(color: .teal, radius: 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .animation(.easeOut, value: color)
    }
}

struct IconTextField_Previews: PreviewProvider {
    static var previews: some View {
        IconTextField(icon: "key.fill", color: .teal)
    }
}
