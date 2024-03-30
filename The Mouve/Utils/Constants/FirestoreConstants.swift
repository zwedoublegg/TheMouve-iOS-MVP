//
//  FireStoreConstants.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/17/24.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let MouvesCollection = Firestore.firestore().collection("mouves")
    static let UsersCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
    
}
