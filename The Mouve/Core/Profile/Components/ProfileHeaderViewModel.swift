//
//  ProfileHeaderViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/9/24.
//

import Foundation
import Combine

@MainActor
class ProfileHeaderViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
        fecthUserStats()
    }
    
    func fecthUserStats() {
        guard user.stats == nil else {return}
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}
