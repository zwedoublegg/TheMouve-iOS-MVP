//
//  UserContentListViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import Foundation

@MainActor
class UserContentListViewModel: ObservableObject {
    @Published var mouves = [Mouve]()
    @Published var attendingMouves = [Mouve]()
    
    let user: User
    
    init(user: User){
        self.user = user
        Task {
            try await fetchUserMouves()
            try await fetchAttendingMouves()
        }
    }
    
    func fetchUserMouves() async throws {
        var mouves = try await MouveService.fetchUserMouves(uid: user.id)
        
        for i in 0 ..< mouves.count {
            mouves[i].user = self.user
        }
        
        self.mouves = mouves
    }
    
    func fetchAttendingMouves() async throws {
        self.attendingMouves = try await MouveService.fetchMouves()
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
