//
//  UserService.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/7/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await FirestoreConstants.UsersCollection.document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await FirestoreConstants.UsersCollection.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        FirestoreConstants.UsersCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
    
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        let query = FirestoreConstants.UsersCollection
        if let limit { query.limit(to: limit) }
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await query.getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self)})
        return users.filter({ $0.id != currentUserUid })
    }
    
    static func fetchUsers(forConfig config: UserListConfig) async throws -> [User] {
        switch config {
        case .attending(let mouveId):
            return try await fetchMouveAttendees(mouveId: mouveId)
        case .followers(let uid):
            return try await fetchFollowers(uid: uid)
        case .following(let uid):
            return try await fetchFollowing(uid: uid)
        case .explore:
            return try await fetchAllUsers()
        case .friends:
            return try await fetchAllUsers()
        }
    }
    
    private static func fetchFollowers(uid: String) async throws -> [User] {
        let snapshot = try await FirestoreConstants.FollowersCollection
            .document(uid)
            .collection("user-followers")
            .getDocuments()
        
        return try await fetchUsers(snapshot)
    }
    
    private static func fetchFollowing(uid: String) async throws -> [User] {
        let snapshot = try await FirestoreConstants.FollowingCollection
            .document(uid)
            .collection("user-following")
            .getDocuments()
        
        return try await fetchUsers(snapshot)
    }
    
    private static func fetchMouveAttendees(mouveId: String) async throws -> [User] {
        return []
    }
    
    private static func fetchUsers(_ snapshot: QuerySnapshot) async throws -> [User] {
        var users = [User]()
        for doc in snapshot.documents {
            users.append(try await fetchUser(withUid: doc.documentID))
        }
        return users
    }
    
    func reset() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection(GlobalConstants.firebaseUsersCollection).document(currentUserUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
}

// MARK: - Following
extension UserService {
    static func follow(uid: String) async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await FirestoreConstants.FollowingCollection
            .document(currentUserUid)
            .collection("user-following")
            .document(uid)
            .setData([:])
        
        async let _ = try await FirestoreConstants.FollowersCollection
            .document(uid)
            .collection("user-followers")
            .document(currentUserUid)
            .setData([:])
    }
    
    static func unfollow(uid: String) async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }

        async let _ = try await FirestoreConstants.FollowingCollection
            .document(currentUserUid)
            .collection("user-following")
            .document(uid)
            .delete()
        
        async let _ = try await FirestoreConstants.FollowersCollection
            .document(uid)
            .collection("user-followers")
            .document(currentUserUid)
            .delete()
    }
    
    static func checkIfUserIsFollowed(uid: String) async throws -> Bool{
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await FirestoreConstants.FollowingCollection
            .document(currentUserUid)
            .collection("user-following")
            .document(uid)
            .getDocument()
        
        return snapshot.exists
    }
    
}

// MARK: - User Stats
extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats{
        async let followingCount = FirestoreConstants.FollowingCollection
            .document(uid)
            .collection("user-following")
            .getDocuments()
            .count
        
        async let followersCount = FirestoreConstants.FollowersCollection
            .document(uid)
            .collection("user-followers")
            .getDocuments()
            .count
        
        async let mouvesCount = FirestoreConstants.MouvesCollection
            .whereField("owneruid", isEqualTo: uid)
            .getDocuments()
            .count
        
        print("DEBUG: did call fetch user stats here and now. With uid \(uid)")
        return try await .init(followingCount: followingCount, followersCount: followersCount, friendsCount: 0, mouveCount: mouvesCount)
    }
}
