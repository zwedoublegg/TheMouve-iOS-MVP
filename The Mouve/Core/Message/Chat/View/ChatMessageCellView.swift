//
//  ChatMessageCellView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/14/24.
//

import SwiftUI

struct ChatMessageCellView: View {
    let message: Message
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentuser
    }
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                Text(verbatim: message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemCyan))
                    .foregroundColor(Color(.white))
                    .clipShape(ChatBubbleView(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack (alignment: .bottom, spacing: 8){
                    
                    CircularProfileImageView(user: message.user, size: .xSmall)
                    
                    Text(verbatim: message.messageText)
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(Color(.black))
                        .clipShape(ChatBubbleView(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ChatMessageCellView(message: Message.MOCK_MESSAGE)
}
