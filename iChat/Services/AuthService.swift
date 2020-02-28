//
//  AuthService.swift
//  iChat
//
//  Created by Георгий Кашин on 28.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class AuthService {
    
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    private init() {}
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let email = email,
            let password = password else {
                return completion(.failure(AuthError.notFilled))
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                return completion(.failure(error!))
            }
            
            completion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            return completion(.failure(AuthError.notFilled))
        }
        
        guard Validators.isSimpleEmail(email!) else {
            return completion(.failure(AuthError.invalidEmail))
        }
        
        guard password! == confirmPassword! else {
            return completion(.failure(AuthError.passwordsNotMatched))
        }
        
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                return completion(.failure(error!))
            }
            
            completion(.success(result.user))
        }
    }
    
}
