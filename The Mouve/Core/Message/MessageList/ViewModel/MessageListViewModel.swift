//
//  MessageListViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/14/24.
//

import Foundation
import Firebase
import Combine
import PhotosUI
import SwiftUI

class MessageListViewModel: ObservableObject{
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
        
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants
            .MessagesCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let fetchedMessages = documents.compactMap({ try? $0.data(as: Message.self) })
            self.loadMessageUser(fromMessages: fetchedMessages)
        }
    }
    
    private func loadMessageUser(fromMessages fetchedMessages: [Message]){
        var messages = fetchedMessages
        print(messages)
        for i in 0..<messages.count {
            let message = messages[i]
            
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i]) //TODO: filter based on timestamp
            }
        }
    }
}
