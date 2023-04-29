//
//  AuthenticationFirebaseDatasource.swift
//  App_H
//
//  Created by Adrián Reyes on 29/04/23.
//


import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthenticationFirebaseDatasource {
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            print("New user created with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
}
