//
//  MessageListView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct MessageListView: View {
    @State private var showNewMessageView = false
    @State private var selectedUser: User?
    @State private var showChatView = false
    @State private var onlineFriends = false
    @StateObject var viewModel = MessageListViewModel()

    
    private var currentUser: User? {
        return viewModel.currentUser
    }

    var body: some View {
        NavigationStack {
            List {
                if onlineFriends{
                    ActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical)
                        .padding(.horizontal, 4)
                }
                
                ForEach (viewModel.recentMessages.sorted(by: { $0.timestampDateVale > $1.timestampDateVale })) { message in
                    ZStack {
                        NavigationLink(value: message){
                            EmptyView()
                        }.opacity(0.0)
                        
                        MessageListRowView(message: message)
                    }
                }
            }
            .padding(.vertical)
            .listStyle(PlainListStyle())
            .onChange(of: selectedUser) { newValue in //remove "newValue in" for iOS 17+
                showChatView = newValue != nil
            }
            .onAppear(perform: {
                print("see me") //TODO: use this to refresh after sending message
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                case .chatView(let user):
                    ChatView(user: user)
                case .notifications:
                    Text("")
//                    NotificationsView()
                }
            })
            .navigationDestination(isPresented: $showChatView, destination: {
                if let user = selectedUser {
                    ChatView( user: user )
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {                        
                        Text("Messages")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showNewMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}

#Preview {
    MessageListView()
}
