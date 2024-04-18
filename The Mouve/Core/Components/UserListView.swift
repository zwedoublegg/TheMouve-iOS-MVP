//
//  UserListView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/16/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel = UserListViewModel()
    private let config: UserListConfig
    
    init(config: UserListConfig) {
        self.config = config
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach (viewModel.users) { user in
                    NavigationLink(value: user) {
                        VStack {
                            UserCell(user: user)
                            
                            Divider().padding(.horizontal)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchUsers(forConfig: config)
        }
    }
}

#Preview {
    UserListView(config: .explore)
}
