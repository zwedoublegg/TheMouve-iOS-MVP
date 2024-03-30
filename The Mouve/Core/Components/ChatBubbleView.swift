//
//  ChatBubbleView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/14/24.
//

import SwiftUI

struct ChatBubbleView: Shape {
    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, 
                                byRoundingCorners: [
                                    .topRight,
                                    .topLeft,
                                    isFromCurrentUser ? .bottomLeft : .bottomRight
                                ],
                                cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

#Preview {
    ChatBubbleView(isFromCurrentUser: true)
}
