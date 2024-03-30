//
//  Message.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/14/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let read: Bool
    let timestamp: Timestamp
    
    var user: User?
    var id: String {
        return messageId ?? NSUUID().uuidString
    }
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentuser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timestampString: String {
        return timestamp.dateValue().timestampString()
    }
    
    var timestampDateVale: TimeInterval {
        return timestamp.dateValue().timeIntervalSince1970
    }
}

extension Message {
    static let MOCK_MESSAGE = Message(messageId: "1111", fromId: "2222", toId: "3333", messageText: "This is mock message text", read: false, timestamp: Timestamp(), user: User.MOCK_USER)
}
