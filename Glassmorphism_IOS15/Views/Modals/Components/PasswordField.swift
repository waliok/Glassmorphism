//
//  PasswordField.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 17/03/2023.
//

import SwiftUI

struct PasswordField: View {
    
    var iconColor: Color
    @Binding var password: String
    @Binding var showPassword: Bool
    @Binding var circleColor: Color
    @FocusState.Binding var focusedField: Field?
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            ZStack {
                Group {
                    
                    SecureField("", text: $password)
                        .font(.custom("Bagnard", size: 32))
                        .foregroundColor(Color("TextField"))
                        .textContentType(.password)
                        .placeholder("Password", when: password.isEmpty)
                        .focused($focusedField, equals: .securePass)
                        .opacity(showPassword ? 0 : 1)
                        .onTapGesture {}
                    
                    TextField("", text: $password)
                        .font(.custom("Bagnard", size: 32))
                        .foregroundColor(Color("TextField"))
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .placeholder("Password", when: password.isEmpty)
                        .focused($focusedField, equals: .unsecurePass)
                        .opacity(showPassword ? 1 : 0)
                        .onTapGesture {}
                }
            }
            .padding(15)
            .padding(.leading, 40)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .clipped()
            
            HStack {
                IconTextField(icon: "key.fill", color: focusedField == .unsecurePass || focusedField == .securePass ? iconColor : iconColor.opacity(0.35))
                Spacer()
                Button {
                    showPassword.toggle()
                    focusedField = focusedField == .securePass ? .unsecurePass : .securePass
                } label: {
                    Image(systemName: self.showPassword ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(focusedField == .unsecurePass || focusedField == .securePass ? iconColor : iconColor.opacity(0.35))
                        .padding()
                }
            }
        }
        .modifier(OutlineOverlay(cornerRadius: 20))
        .shadow(color: focusedField == .unsecurePass || focusedField == .securePass ? circleColor : .clear, radius: 10, x: 0, y: 0)
        .modifier(OutlineOverlay(cornerRadius: 20))
    }
}

