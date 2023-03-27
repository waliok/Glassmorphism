//
//  ModalView.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 13/03/2023.
//

import SwiftUI

struct ModalView: View {
    
    @State var viewState: CGSize = .zero
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    @AppStorage("isLogged") var isLogged = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .onTapGesture { dismissModal() }
                .opacity(appear[0] ? 1 : 0)
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                Group {
                    switch model.selectedModal {
                    case .signUp: SignUpView()
                    case .signIn: SignInView()
                    }
                }
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .rotationEffect(.degrees(viewState.width/40))
                .rotation3DEffect(.degrees(viewState.height/20), axis: (x: 1, y: 0, z: 0))
                .hueRotation(.degrees(viewState.width/5))
                .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
                .padding(20)
                .offset(x: viewState.width, y: viewState.height)
                .opacity(appear[0] ? 1 : 0)
                .gesture(drag)
                .frame(maxHeight: .infinity, alignment: .center)
                .offset(y: appear[0] ? 0 : proxy.size.height)
                .background(
                    Image("Blob 1")
                        .offset(x: 150, y: -60)
                        .opacity(appear[2] ? 1 : 0)
                        .offset(y: appear[2] ? -10 : 0)
                        .blur(radius: appear[2] ? 0 : 40)
                        .hueRotation(.degrees(viewState.width / 5))
                        .allowsHitTesting(false))
            }
            
            Button {
                dismissModal()
            } label: {
                CloseButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            .opacity(appear[1] ? 1 : 0)
            .offset(y: appear[1] ? 0 : -200)
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            withAnimation(.spring()) {
                appear[0] = true
            }
            withAnimation(.spring().delay(0.1)) {
                appear[1] = true
            }
            withAnimation(.easeOut(duration: 2)) {
                appear[2] = true
            }
        }
        .onDisappear {
            withAnimation(.spring()) {
                appear[0] = false
            }
            withAnimation(.spring().delay(0.1)) {
                appear[1] = false
            }
            withAnimation(.easeOut(duration: 1)) {
                appear[2] = false
            }
        }
        .onChange(of: isLogged) { newValue in
            guard newValue else { return }
            dismissModal()
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                viewState = value.translation
                if value.translation.width > 150 {
                    withAnimation {
                        dismissModal()
                    }
                }
            }
            .onEnded { value in
                if value.translation.height > 200 {
                    dismissModal()
                } else {
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func dismissModal() {
        withAnimation(.spring()) {
            appear[0] = false
        }
        withAnimation(.spring().delay(0.1)) {
            appear[1] = false
        }
        withAnimation {
            appear[2] = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            model.showModal = false
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
            .environmentObject(Model())
    }
}
