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
    
    func uploadCommentNotification(toUid uid: String, mouve: Mouve) {
        service.uploadNotification(toUid: uid, type: .comment, mouve: mouve)
    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotification(toUid: uid, type: .follow)
    }
}
