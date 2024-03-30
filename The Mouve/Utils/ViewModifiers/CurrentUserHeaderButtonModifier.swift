//
//  CurrentUserHeaderButtonModifier.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//

import SwiftUI

struct CurrentUserHeaderButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(width: 150, height: 32)
            .background(.white)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color(.systemGray4)))
    }
}
