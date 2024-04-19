//
//  TMNotification.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/18/24.
//

import Foundation
import Firebase

struct TMNotification: Identifiable, Codable {
    let id: String
    var mouveId: String?
    let notificationSenderUid: String
    let timestamp: Timestamp
    let type: TMNotificationType
    
    var mouve: Mouve?
    var user: User?
}

extension TMNotification {
    static let MOCK_NOTIFICATIONS: [TMNotification] = [
        TMNotification(id: "1232", notificationSenderUid: "123434", timestamp: Timestamp(), type: .attend, mouve: Mouve.MOCK_MOUVE),
        TMNotification(id: "1234", notificationSenderUid: "123534", timestamp: Timestamp(), type: .attend, mouve: Mouve.MOCK_MOUVE),
        TMNotification(id: "1235", notificationSenderUid: "123634", timestamp: Timestamp(), type: .follow, user: User.MOCK_USER),
        TMNotification(id: "1236", notificationSenderUid: "123734", timestamp: Timestamp(), type: .attend, mouve: Mouve.MOCK_MOUVE),
        TMNotification(id: "1237", notificationSenderUid: "123834", timestamp: Timestamp(), type: .attend, mouve: Mouve.MOCK_MOUVE),
        TMNotification(id: "1238", notificationSenderUid: "123934", timestamp: Timestamp(), type: .follow, user: User.MOCK_USER),
        TMNotification(id: "1239", notificationSenderUid: "123034", timestamp: Timestamp(), type: .comment, mouve: Mouve.MOCK_MOUVE),
        TMNotification(id: "1230", notificationSenderUid: "123134", timestamp: Timestamp(), type: .comment, mouve: Mouve.MOCK_MOUVE),
        TMNotification(id: "1231", notificationSenderUid: "123234", timestamp: Timestamp(), type: .follow, user: User.MOCK_USER)
    ]
}
