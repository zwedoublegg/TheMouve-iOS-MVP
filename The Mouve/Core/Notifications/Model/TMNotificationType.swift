//
//  TMNotificationType.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/18/24.
//

import Foundation

enum TMNotificationType: Int, Codable {
    case attend
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .attend: return "is attending your mouve."
        case .comment: return "commented on your mouve."
        case .follow: return "started following you."
        }
    }
}
