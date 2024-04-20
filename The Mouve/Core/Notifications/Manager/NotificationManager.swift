//
//  NotificationManager.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/18/24.
//

import Foundation

class NotificationManager {
    
    static let shared = NotificationManager()
    private let service = NotificationService()
    
    private init() {
        
    }
    
    func uploadAttendNotification(toUid uid: String, mouve: Mouve) {
        service.uploadNotification(toUid: uid, type: .attend, mouve: mouve)
    }
    
    func deleteAttendNotification(notificationOwnerUid uid: String, mouve: Mouve) async throws{
        do {
            try await service.deleteNotification(toUid: uid, type: .attend, mouve: mouve)
        } catch {
            print("DEBUG: failed to delete attend notification with error: \(error.localizedDescription)")
        }
    }
    
    func uploadCommentNotification(toUid uid: String, mouve: Mouve) {
        service.uploadNotification(toUid: uid, type: .comment, mouve: mouve)
    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotification(toUid: uid, type: .follow)
    }
    
    func deleteFollowNotification(notificationOwnerUid uid: String) async throws{
        do {
            try await service.deleteNotification(toUid: uid, type: .follow)
        } catch {
            print("DEBUG: failed to delete follow notification with error: \(error.localizedDescription)")
        }
    }
}
