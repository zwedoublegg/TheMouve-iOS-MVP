//
//  MessageListRowView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import SwiftUI

struct MessageListRowView: View {
    let message: Message
    var body: some View {
        HStack(alignment: .top, spacing: 12){
            
            CircularProfileImageView(user: message.user, size: .large)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top, spacing: 12){
                    Text(verbatim: message.user?.username ?? "")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    HStack {
                        Text(message.timestampString)
                        
                        Image(systemName: "chevron.right")
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
                
                Text(verbatim: message.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
        }
        .frame(height: 72)
    }
}

#Preview {
    MessageListRowView(message: Message.MOCK_MESSAGE)
}
