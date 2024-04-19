//
//  NotificationService.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/18/24.
//

import Foundation
import Firebase

class NotificationService {
    
    func fetchNotifications() async throws -> [TMNotification] {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await FirestoreConstants
            .UserNotificationCollection(uid: currentUserUid)
            .getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: TMNotification.self)})
    }
    
    func uploadNotification(toUid uid: String, type: TMNotificationType, mouve: Mouve? = nil) {
        guard let currentUserUid = Auth.auth().currentUser?.uid, uid != currentUserUid else { return }
        
        let ref = FirestoreConstants.UserNotificationCollection(uid: uid)
            .document()
        
        let notification = TMNotification(id: ref.documentID,
                                          mouveId: mouve?.id,
                                          notificationSenderUid: currentUserUid,
                                          timestamp: Timestamp(),
                                          type: type)
        
        guard let notificationData = try? Firestore.Encoder().encode(notification) else { return }
        
        ref.setData(notificationData)
    }
    
    func deleteNotification(toUid uid: String, type: TMNotificationType, mouve: Mouve? = nil) {
        
    }
}
