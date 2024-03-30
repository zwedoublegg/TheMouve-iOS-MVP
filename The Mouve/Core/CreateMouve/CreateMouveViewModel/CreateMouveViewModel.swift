//
//  CreateMouveViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import Foundation
import Firebase
import FirebaseAuth

class CreateMouveViewModel: ObservableObject{
    
    func uploadMouve(mouveCaption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let mouve = Mouve(attendees: 0, mouveCaption: mouveCaption, ownerUid: uid, timestamp: Timestamp(), title: "")
        try await MouveService.uploadMouve(mouve)
    }
    
    func sendPromptToGPT(prompt: String) async throws {
        try await OpenAIService.shared.sendPromptToChatGPT(prompt: prompt)
    }
    
}
