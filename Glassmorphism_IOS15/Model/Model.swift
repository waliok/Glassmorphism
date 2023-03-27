//
//  Model.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 02/03/2023.
//

import SwiftUI

class Model: ObservableObject {
    @Published var showTab: Bool = true
    
    @Published var showNav: Bool = true
    
    @Published var selectedModal: Modal = .signIn
    @Published var showModal = false
    @Published var dismissModal: Bool = false
    
    @Published var showDetail: Bool = false
    @Published var selectedCourse: Int = 0
}

enum Modal: String {
    case signUp
    case signIn
}
