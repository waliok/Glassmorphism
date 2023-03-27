//
//  EmailField.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 17/03/2023.
//

import SwiftUI

struct EmailField: View {
    
    var iconColor: Color
    @Binding var email: String
    @Binding var circleColor: Color
    @FocusState.Binding var focusedField: Field?
    
    var body: some View {
        TextField("", text: $email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .font(.custom("Bagnard", size: 32))
            .foregroundColor(Color("TextField"))
            .placeholder("Email address", when: email.isEmpty)
            .addIcon(icon: "envelope.open.fill", color: focusedField == .email ? iconColor : iconColor.opacity(0.35))
            .focused($focusedField, equals: .email)
            .onTapGesture {}
            .outlineOverlay()
            .shadow(color: focusedField == .email ? circleColor : .clear, radius: 8, x: 0, y: 0)
            .outlineOverlay()
    }
}
