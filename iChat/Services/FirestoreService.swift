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
    
    var currentUser: MUser!
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private init() {}
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    return completion(.failure(UserError.cannotUnwrapToMUser))
                }
                self.currentUser = muser
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            return completion(.failure(UserError.notFilled))
        }
        
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {
            return completion(.failure(UserError.photoNotExist))
        }
        
        var muser = MUser(id: id, email: email, username: username!, imageName: "not exist", description: description!, sex: sex!)
        
        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {
            case .success(let url):
                muser.imageName = url.absoluteString
                self.usersRef.document(muser.id).setData(muser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
        let reference = db.collection(["users", receiver.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")
        
        let message = MMessage(user: currentUser, content: message)
        let chat = MChat(friendId: currentUser.id, friendUsername: currentUser.username, friendImageName: currentUser.imageName, lastMessageContent: message.content)
        
        reference.document(currentUser.id).setData(chat.representation) { error in
            if let error = error {
                return completion(.failure(error))
            }
            messageRef.addDocument(data: message.representation) { error in
                if let error = error {
                    return completion(.failure(error))
                }
                completion(.success(Void()))
            }
        }
    }
}
