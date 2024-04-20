//
//  FeedViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import Foundation
import Firebase
import UIKit

@MainActor
class FeedViewModel: ObservableObject {
    @Published var mouves = [Mouve]()
    @Published var followingMouves = [Mouve]()
    
    init() {
        Task {
            try await fetchMouves()
            try await fetchFollowingMouves()
        }
    }
    
    func fetchMouves() async throws {
        self.mouves = try await MouveService.fetchMouves()
        try await fetchUserDataForMouves()
    }
    
    func fetchFollowingMouves() async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        let userFollowing = try await UserService.fetchUsers(forConfig: .following(uid: currentUserUid))
        let arrayOfUid = userFollowing.map({ $0.uid })
        
        self.followingMouves = self.mouves.filter({ arrayOfUid.contains($0.user?.id)})
    }
    
    private func fetchUserDataForMouves() async throws  {
        for i in 0 ..< mouves.count {
            let mouve = mouves[i]
            let ownerUid = mouve.ownerUid
            let mouveUser = try await UserService.fetchUser(withUid: ownerUid)
            
            mouves[i].user = mouveUser
        }
    }
    
}
