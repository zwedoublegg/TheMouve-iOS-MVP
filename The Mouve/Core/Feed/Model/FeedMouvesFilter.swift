//
//  FeedModelFilter.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/2/24.
//

import Foundation
import SwiftUI

enum FeedMouvesFilter: Int, CaseIterable, Identifiable {
    case scene
    case following
    
    var title: String {
        switch self {
        case .scene: return "Scene"
        case .following: return "Following"
        }
    }
    
    var id: Int { return self.rawValue }
}
