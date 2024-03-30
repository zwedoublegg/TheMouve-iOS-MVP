//
//  SendMessageBackgroundView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/18/24.
//

import SwiftUI

struct SendMessageBackgroundView: Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [
                                    .topRight,
                                    .topLeft,
                                    .bottomLeft,
                                    .bottomRight
                                ],
                                cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

#Preview {
    SendMessageBackgroundView()
}
