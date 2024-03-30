//
//  ProfileViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/7/24.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            
            print("DEBUG: User from combine \(String(describing: user))")
        }.store(in: &cancellables)
    }
}
