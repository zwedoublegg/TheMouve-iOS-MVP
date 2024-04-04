//
//  Mouve.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Mouve: Identifiable, Codable {
    @DocumentID var mouveId: String?
    var attendees: Int
    var mouveCaption: String
    let ownerUid: String
    let timestamp: Timestamp
    var title: String
    var user: User?
    
    var didAttend: Bool? = false
    
    var id: String {
        return mouveId ?? NSUUID().uuidString
    }
}

extension Mouve {
    static let MOCK_MOUVE = Mouve(attendees: 0, mouveCaption: "This is a test caption", ownerUid: "123", timestamp: Timestamp(), title: "This is a test mouve title")
}
