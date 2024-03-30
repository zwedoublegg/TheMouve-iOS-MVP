////
////  MessageListService.swift
////  The Mouve
////
////  Created by Samuel Ojogbo on 3/17/24.
////
//
//import Foundation
////import Firebase
//
//class MessageListService{
//    @Published var recentMessages = [Message]()
//    @Published var documentChanges = [DocumentChange]()
//    
//    static let shared = MessageListService()
//    
//    init() {
//        observeRecentMessages()
//    }
//    
//    func observeRecentMessages() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        let query = FirestoreConstants
//            .MessagesCollection
//            .document(uid)
//            .collection("recent-messages")
//            .order(by: "timestamp", descending: true)
//        
//        query.addSnapshotListener { snapshot, _ in
//            guard let changes = snapshot?.documentChanges.filter({
//                $0.type == .added || $0.type == .modified
//            }) else { return }
//            
//            self.documentChanges = changes
//            
//            print(changes)
//        }
//        
////        query.getDocuments { snapshot, error in
////            guard let documents = snapshot?.documents else { return }
////            
////            self.recentMessages = documents.compactMap({ try? $0.data(as: Message.self) })
////        }
//    }
//}
