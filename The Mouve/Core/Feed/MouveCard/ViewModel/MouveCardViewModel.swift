//
//  MouveCardViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/3/24.
//

import Foundation

@MainActor
class MouveCardViewModel: ObservableObject {
    @Published var mouve: Mouve

    init(mouve: Mouve){
        self.mouve = mouve
        Task {
            try await isUserAttendingMouve()
        }
    }
    
    func attend() async throws {
        do {
            let mouveCopy = mouve
            mouve.didAttend = true
            mouve.attendees += 1

            try await MouveService.attendMouve(mouveCopy)
            NotificationManager.shared.uploadAttendNotification(toUid: mouve.ownerUid, mouve: mouve)
        } catch {
            mouve.didAttend = false
            mouve.attendees -= 1
            print("error attending mouve")
        }
    }
    
    func unAttend() async throws {
        do {
            let mouveCopy = mouve
            mouve.didAttend = false
            mouve.attendees -= 1

            try await MouveService.unattendMouve(mouveCopy)
        } catch {
            mouve.didAttend = true
            mouve.attendees += 1
            print("error unattending mouve")
        }
    }
    
    func isUserAttendingMouve() async throws{
        self.mouve.didAttend = try await MouveService.isUserAttendingMouve(mouve)
    }
}
