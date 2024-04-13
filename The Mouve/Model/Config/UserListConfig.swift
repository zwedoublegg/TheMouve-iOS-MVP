//
//  UserListConfig.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/13/24.
//

import Foundation

enum UserListConfig: Hashable {
    case followers(uid: String)
    case following(uid: String)
    case attending(mouveId: String)
    
    var navigationTitle: String {
        switch self {
        case .followers: return "Followers"
        case .following: return "Following"
        case .attending: return "Attendees"
        }
    }
}
