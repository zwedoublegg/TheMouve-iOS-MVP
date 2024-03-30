//
//  UserSocialMediaButtonModifier.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//

import SwiftUI

struct UserSocialMediaButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 40, height: 32)
            .background(.black)
            .cornerRadius(8)
    }
}
