//
//  ChatService.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/17/24.
//

import Foundation
import Firebase

struct ChatService {
    let chatPartner: User
    
    func sendMessage (_ messageText: String){
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        let chartPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollection
            .document(currentUserUid)
            .collection(chartPartnerId)
            .document()
        let chatPartnerRef = FirestoreConstants.MessagesCollection
            .document(chartPartnerId)
            .collection(currentUserUid)
        let recentCurrentUserRef = FirestoreConstants.MessagesCollection
            .document(currentUserUid)
            .collection("recent-messages")
            .document(chartPartnerId)
        let recentChatPartnerRef = FirestoreConstants.MessagesCollection
            .document(chartPartnerId)
            .collection("recent-messages")
            .document(currentUserUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(messageId: messageId,
                              fromId: currentUserUid,
                              toId: chartPartnerId,
                              messageText: messageText,
                              read: false,
                              timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        recentCurrentUserRef.setData(messageData)
        recentChatPartnerRef.setData(messageData)
    }
    
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants.MessagesCollection
            .document(currentUserUid)
            .collection(chatPartner.id)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
            
            for(index, message) in messages.enumerated() where !message.isFromCurrentuser {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
