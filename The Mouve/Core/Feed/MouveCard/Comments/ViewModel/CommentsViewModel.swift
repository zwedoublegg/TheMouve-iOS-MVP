//
//  CommentsViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/5/24.
//

import Foundation
import Firebase

@MainActor
class CommentsViewModel: ObservableObject {
    @Published var comments = [Comment]()
    private let mouve: Mouve
    private let service: CommentsService
    
    init(mouve: Mouve){
        self.mouve = mouve
        self.service = CommentsService(mouveId: mouve.id)
        
        Task{
            try await fetchComments()
        }
    }
    
    func uploadComment(commentText: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let comment = Comment(
            commentText: commentText,
            commentOwnerUid: uid,
            mouveId: mouve.id,
            mouveOwnerUid: mouve.ownerUid,
            timestamp: Timestamp())
        
        do{
            try await service.uploadcomment(comment)
            try await fetchComments()
        } catch {
            print("Error from CommentsViewModel")
        }
    }
    
    func fetchComments() async throws {
        self.comments = try await service.fetchComments()
        try await fetchUserDataForComments()
    }
    
    private func fetchUserDataForComments() async throws  {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let user = try await UserService.fetchUser(withUid: comment.commentOwnerUid)
            
            comments[i].user = user
        }
    }
}
