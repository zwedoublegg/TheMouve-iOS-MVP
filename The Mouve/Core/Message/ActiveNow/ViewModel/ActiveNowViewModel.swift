//
//  ActiveNowViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/18/24.
//

import Foundation

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    @MainActor
    private func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers(limit: 100)
    }
}
