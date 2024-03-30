//
//  PreviewProvider.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//
//TODO: Delete file Entension deprecated
import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(uid: "123", fullName: "Jiggy The Don", email: "jig@jig.com", username: "jiggyTheDon") // uid could be NSUUID().uuidString
    let mouve = Mouve(attendees: 0, mouveCaption: "This is a test caption", ownerUid: "123", timestamp: Timestamp(), title: "This is a test mouve title")
}
