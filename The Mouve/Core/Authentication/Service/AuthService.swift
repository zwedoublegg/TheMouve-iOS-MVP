//
//  AuthService.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/5/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
//            print(" New user: \(result.user.uid)")
        } catch {
            print(" Failed to create new user with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullName: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, fullName: fullName, username: username, id: result.user.uid)
//            print(" New user: \(result.user.uid)")
        } catch {
            print(" Failed to create new user with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func uploadUserData(
        withEmail email: String,
        fullName: String,
        username: String,
        id: String
    ) async throws {
        let user = User(uid: id, fullName: fullName, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection(GlobalConstants.firebaseUsersCollection).document(id).setData(userData)
        UserService.shared.currentUser = user
    }
    
    func signOut() {
        try? Auth.auth().signOut() //To sign user out on backend
        self.userSession = nil     //To remove user session locally and update routing
        UserService.shared.reset() //Sets current user object to nil
    }
}
