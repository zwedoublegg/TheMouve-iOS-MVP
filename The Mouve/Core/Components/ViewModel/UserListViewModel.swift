//
//  UserListViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/16/24.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
    }
    
//    private func fetchAllUsers() async throws {
//        self.users = try await UserService.fetchAllUsers()
//    }
    
    func fetchUsers(forConfig config: UserListConfig) async  {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        } catch {
            print("error")
        }
    }
}
