//
//  AuthenticationRepository.swift
//  App_H
//
//  Created by Adrián Reyes on 29/04/23.
//

import Foundation
import FirebaseAuth

final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    
    func getCurrentUser() -> User? {
            authenticationFirebaseDatasource.getCurrentUser()
        }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDatasource.createNewUser(email: email,
                                                       password: password,
                                                       completionBlock: completionBlock)
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
            authenticationFirebaseDatasource.login(email: email,
                                                   password: password,
                                                   completionBlock: completionBlock)
        }
    
    func logout() throws {
            try authenticationFirebaseDatasource.logout()
        }
    
    func updatePassword(newPassword: String, completionBlock: @escaping (Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completionBlock(NSError(domain: "Auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No hay usuario autenticado"]))
            return
        }
        
        user.updatePassword(to: newPassword) { error in
            if let error = error {
                completionBlock(error)
            } else {
                completionBlock(nil)
            }
        }
    }
    
}
