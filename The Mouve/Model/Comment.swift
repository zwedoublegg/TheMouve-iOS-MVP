//
//  MouveComment.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/5/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Comment: Identifiable, Hashable, Codable {
    @DocumentID var commentId: String?
    let commentText: String
    let commentOwnerUid: String
    let mouveId: String
    let mouveOwnerUid: String
    let timestamp: Timestamp
    
    var user: User?
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
}

extension Comment {
    static let MOCK_COMMENT = Comment(commentText: "Testing comment for now", commentOwnerUid: "123", mouveId: "234", mouveOwnerUid: "123", timestamp: Timestamp())
}
