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
        auth.signIn(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                return completion(.failure(error!))
            }
            
            completion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                return completion(.failure(error!))
            }
            
            completion(.success(result.user))
        }
    }
    
}
