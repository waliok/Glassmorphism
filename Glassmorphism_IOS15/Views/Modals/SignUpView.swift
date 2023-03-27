//
//  SignUpView.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 07/03/2023.
//

import SwiftUI

struct SignUpView: View {
    
    let color: Color = Color(uiColor: .magenta)
    
//    var dismissModal: () -> Void
    @State var email = ""
    @State var password = ""
    @State var showPassword: Bool = false
    @State var circleY: CGFloat = 160
    @State var emailY: CGFloat = 0
    @State var passwordY: CGFloat = 0
    @State var circleColor: Color = .clear
    @State var animation: Animation? = .default
    @State var appear = [false, false, false]
    @FocusState var focusedField: Field?
    @EnvironmentObject var model: Model
    @AppStorage("isLogged") var isLogged = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sign Up")
                .font(.largeTitle).bold()
                .blendMode(.overlay)
                .slideFadeIn(show: appear[0], offset: 30)
            
            Text("Access 120+ hours of courses, tutorials and livestreams")
                .font(.headline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .slideFadeIn(show: appear[1], offset: 20)
            
            EmailField(iconColor: color, email: $email, circleColor: $circleColor, focusedField: $focusedField)
                .addGeometryReader()
                .onPreferenceChange(CirclePreferenceKey.self) { value in
                    emailY = value
                }
            
            PasswordField(iconColor: color, password: $password, showPassword: $showPassword,  circleColor: $circleColor, focusedField: $focusedField)
                .addGeometryReader()
                .onPreferenceChange(CirclePreferenceKey.self) { value in
                    passwordY = value
                }
            
            Button {
                model.dismissModal.toggle()
                isLogged = true
            } label: {
                Text("Create an account")
                    .frame(maxWidth: .infinity)
            }
            .font(.headline)
            .blendMode(.overlay)
            .buttonStyle(.angular)
            .tint(.accentColor)
            .controlSize(.large)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
            
            Group {
                Text("By clicking on ")
                + Text("_Create an account_").foregroundColor(.primary.opacity(0.7))
                + Text(", you agree to our **Terms of Service** and **[Privacy Policy](https://designcode.io)**")
                
                Divider()
                
                HStack {
                    Text("Already have an account?")
                    Button {
                        withAnimation {
                            model.selectedModal = .signIn
                        }
                    } label: {
                        Text("**Sign in**")
                    }
                }
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            .accentColor(.secondary)
            .slideFadeIn(show: appear[2], offset: 10)
        }
        .coordinateSpace(name: "container")
        .padding(20)
        .padding(.vertical, 20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .backgroundColor(opacity: 0.4)
        .background(
            Circle().fill(circleColor)
                .frame(width: 68, height: 68)
                .offset(y: circleY)
                .scaleEffect(appear[0] ? 1 : 0.1)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        .outlineModifier(cornerRadius: 30)
        .frame(maxWidth: 500)
        .onAppear { animate() }
        .onChange(of: focusedField) { value in
            withAnimation {
                if value == .email {
                    circleY = emailY
                    circleColor = color
                    animation = .default
                } else if value == .securePass {
                    circleY = passwordY
                    circleColor = color
                    animation = .default
                } else if value == .unsecurePass {
                    circleY = passwordY
                    circleColor = color
                    animation = .default
                } else {
                    circleColor = .clear
                    animation = .none
                }
            }
        }
        .animation(animation, value: circleColor)
        .task {
            try! await Task.sleep(nanoseconds: 500_000_000)
            focusedField = .email
        }
    }
    
    func animate() {
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.2)) {
            appear[0] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.6)) {
            appear[2] = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignUpView()
                .environmentObject(Model())
        }
    }
}
