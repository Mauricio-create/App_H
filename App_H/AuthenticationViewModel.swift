//
//  AuthenticationViewModel.swift
//  App_H
//
//  Created by Adrián Reyes on 29/04/23.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
    }
    
    func getCurrentUser() {
            self.user = authenticationRepository.getCurrentUser()
        }
    
    func createNewUser(email: String, password: String) {
        authenticationRepository.createNewUser(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newUser):
                self.user = newUser
            case .failure(let error):
                self.messageError = error.localizedDescription
            }
        }
    }
    
    func login(email: String, password: String) {
            authenticationRepository.login(email: email, password: password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let newUser):
                    self.user = newUser
                case .failure(let error):
                    self.messageError = error.localizedDescription
                }
            }
        }
    
    func changePassword(newPassword: String) {
        authenticationRepository.updatePassword(newPassword: newPassword) { error in
            if let error = error {
                self.messageError = error.localizedDescription
            } else {
                // Contraseña actualizada correctamente
            }
        }
    }
    
    func logout() {
            do {
                try authenticationRepository.logout()
                self.user = nil
            } catch {
                print("Error logout")
            }
        }
}
