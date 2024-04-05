//
//  User.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/6/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Hashable {
    
    @DocumentID var uid: String?
    var fullName: String
    let email: String
    var username: String
    var profileImageUrl: String?
    var bio: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
    var firstName: String {
        let formatter = PersonNameComponentsFormatter()
        let components = formatter.personNameComponents(from: fullName)
        return components?.givenName ?? fullName
    }
}


extension User {
    static let MOCK_USER = User(uid: "123", fullName: "Jiggy The Don", email: "jig@jig.com", username: "jiggyTheDon") // uid could be NSUUID().uuidString
}
