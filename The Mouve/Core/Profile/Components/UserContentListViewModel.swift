//
//  UserContentListViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import Foundation

class UserContentListViewModel: ObservableObject {
    @Published var mouves = [Mouve]()
    
    let user: User
    
    init(user: User){
        self.user = user
        Task { try await fetchUserThreads() }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var mouves = try await MouveService.fetchUserMouves(uid: user.id)
        
        for i in 0 ..< mouves.count {
            mouves[i].user = self.user
        }
        
        self.mouves = mouves
    }
}
