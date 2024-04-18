//
//  ProfileViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/7/24.
//

import Foundation
import Combine

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fecthUserStats()
    }
    
    func fecthUserStats() {
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

extension ProfileViewModel {
    func follow() {
        guard user.stats == nil else {return}
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
        }
    }
    
    func unfollow() {
        guard user.stats == nil else {return}
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        guard user.stats == nil else {return}
        Task {
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
}
