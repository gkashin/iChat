//
//  FirestoreService.swift
//  iChat
//
//  Created by Георгий Кашин on 29.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import Firebase
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private init() {}
    
    func saveProfileWith(id: String, email: String, username: String?, imageName: String?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            return completion(.failure(UserError.notFilled))
        }
        
        let muser = MUser(id: id, email: email, username: username!, imageName: "not exist", description: description!, sex: sex!)
        self.usersRef.document(muser.id).setData(muser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(muser))
            }
        }
    }
}
