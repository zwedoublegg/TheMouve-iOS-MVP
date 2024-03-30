//
//  ChatView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/14/24.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    CircularProfileImageView(user: user, size: .xLarge)
                    
                    Text(verbatim: user.username)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                LazyVStack {
                    ForEach (viewModel.messages) { message in
                        ChatMessageCellView(message: message)
                    }
                }
            }
            
            Spacer()
            
            ZStack(alignment: .trailing, content: {
                TextField("Message...",text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(SendMessageBackgroundView())
                    .font(.subheadline)
                
                Button(action: {
                    if !viewModel.messageText.isEmpty {
                        viewModel.sendMessage()
                        viewModel.messageText = ""
                        print("send message")
                    }
                }, label: {
                    Text("Send")
                        .fontWeight(.semibold)
                })
                .padding(.horizontal)
            })
            .padding()
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChatView( user: User.MOCK_USER )
}
