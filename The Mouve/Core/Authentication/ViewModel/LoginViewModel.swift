//
//  LoginViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/6/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(
            withEmail: email,
            password: password)
        print("Logged in User")
    }
}
