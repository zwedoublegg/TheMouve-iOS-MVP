//
//  SearchViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    @MainActor
    private func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
