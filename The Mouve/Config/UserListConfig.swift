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
    case friends(uid: String)
    case attending(mouveId: String)
    case explore
    
    var navigationTitle: String {
        switch self {
        case .followers: return "Followers"
        case .following: return "Following"
        case .friends: return "Friends"
        case .attending: return "Attendees"
        case .explore: return "Search"
        }
    }
}
