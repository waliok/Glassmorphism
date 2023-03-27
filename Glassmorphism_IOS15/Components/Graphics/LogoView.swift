//
//  LogoView.swift
//  Glassmorphism_IOS15
//
//  Created by Waliok on 26/03/2023.
//

import SwiftUI

struct LogoView: View {
    var image = courses[0].logo
    var darkBackground = true
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(18)
            .backgroundStyle(cornerRadius: 18, opacity: 0.4, withDarkBack: darkBackground)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
