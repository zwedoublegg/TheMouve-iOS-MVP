//
//  FireStoreConstants.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/17/24.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let FirestoreRoot = Firestore.firestore()
    static let MouvesCollection = FirestoreRoot.collection("mouves")
    
    static let UsersCollection = FirestoreRoot.collection("users")
    
    static let MessagesCollection = FirestoreRoot.collection("messages")
    
    static let FollowingCollection = FirestoreRoot.collection("following")
    static let FollowersCollection = FirestoreRoot.collection("followers")
    
    static let NotificationsCollection = FirestoreRoot.collection("notifications")
    
    static func UserNotificationCollection(uid: String) -> CollectionReference {
        return NotificationsCollection.document(uid).collection("user-notifications")
    }
}
