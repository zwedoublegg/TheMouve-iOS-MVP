//
//  MouveService.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MouveService {
    
    static func uploadMouve(_ mouve: Mouve) async throws {
        guard let mouveData = try? Firestore.Encoder().encode(mouve) else { return }
        try await Firestore.firestore().collection(GlobalConstants.firebaseMouvesCollection).addDocument(data: mouveData)
    }
    
    static func fetchMouves() async throws -> [Mouve] {
        let snapshot = try await Firestore
            .firestore()
            .collection(GlobalConstants.firebaseMouvesCollection)
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Mouve.self) })
        
    }
    
    static func fetchUserMouves(uid: String) async throws -> [Mouve] {
        let snapshot = try await Firestore
            .firestore()
            .collection(GlobalConstants.firebaseMouvesCollection)
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        let mouves = snapshot.documents.compactMap({ try? $0.data(as: Mouve.self) })
        return mouves.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
}

// MARL - Attendees

extension MouveService {
    static func attendMouve(_ mouve: Mouve) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ =  try await FirestoreConstants.MouvesCollection
            .document(mouve.id)
            .collection("mouve-attendees")
            .document(uid).setData([ : ])
        
        async let _ =  try await FirestoreConstants.MouvesCollection
            .document(mouve.id)
            .updateData(["attendees" : mouve.attendees + 1])
        
        async let _ =  try await FirestoreConstants.UsersCollection
            .document(uid)
            .collection("attending")
            .document(mouve.id).setData([ : ])
    }
    
    static func unattendMouve(_ mouve: Mouve) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ =  try await FirestoreConstants.MouvesCollection
            .document(mouve.id)
            .collection("mouve-attendees")
            .document(uid).delete()
        
        async let _ =  try await FirestoreConstants.MouvesCollection
            .document(mouve.id)
            .updateData(["attendees" : mouve.attendees - 1])
        
        async let _ =  try await FirestoreConstants.UsersCollection
            .document(uid)
            .collection("attending")
            .document(mouve.id).delete()
    }
    
    static func isUserAttendingMouve(_ mouve: Mouve) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirestoreConstants.UsersCollection
            .document(uid)
            .collection("attending")
            .document(mouve.id).getDocument()
        
        return snapshot.exists
    }
}
