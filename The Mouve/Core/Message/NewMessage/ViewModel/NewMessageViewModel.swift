//
//  NewMessageViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/14/24.
//

import Foundation

@MainActor
class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers()}
    }
    
    func fetchAllUsers() async throws{
        self.users = try await UserService.fetchAllUsers()
    }
}
