//
//  MouveCardViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/3/24.
//

import Foundation

class MouveCardViewModel: ObservableObject {
    @Published var mouve: Mouve
    
    init(mouve: Mouve){
        self.mouve = mouve
    }
    
    func attend() async throws {
        mouve.didAttend = true
    }
    
    func unAttend() async throws {
        mouve.didAttend = false
    }
}
