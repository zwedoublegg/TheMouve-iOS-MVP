//
//  ProfileMouveFilter.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/1/24.
//

import Foundation
import SwiftUI

enum ProfileMouvesFilter: Int, CaseIterable, Identifiable {
    case mouves
    case createdMouves
    
    var title: String {
        switch self {
        case .mouves: return "Mouves"
        case .createdMouves: return "Created Mouves"
        }
    }
    
    var id: Int { return self.rawValue }
}
