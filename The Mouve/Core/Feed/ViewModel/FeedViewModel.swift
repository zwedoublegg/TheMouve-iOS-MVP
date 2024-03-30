//
//  FeedViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var mouves = [Mouve]()
    
    init() {
        Task { try await fetchMouves() }
    }
    
    func fetchMouves() async throws {
        self.mouves = try await MouveService.fetchMouves()
        try await fetchUserDataForMouves()
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
