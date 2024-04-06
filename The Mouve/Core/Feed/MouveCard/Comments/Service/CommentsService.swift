//
//  CommentService.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/5/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct CommentsService {
    let mouveId: String
    
    func uploadcomment(_ comment: Comment) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        
        try await FirestoreConstants.MouvesCollection
            .document(mouveId)
            .collection("mouve-comments")
            .addDocument(data: commentData)
    }
    
    func fetchComments() async throws -> [Comment] {
        let snapshot = try await FirestoreConstants.MouvesCollection
            .document(mouveId)
            .collection("mouve-comments")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap ({ try? $0.data(as: Comment.self) })
    }
}
