//
//  StorageService.swift
//  iChat
//
//  Created by Георгий Кашин on 02.03.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import FirebaseAuth
import FirebaseStorage
import UIKit

class StorageService {
    
    static let shared = StorageService()
    let storageRef = Storage.storage().reference()
    
    private var avatarsRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    private init() {}
    
    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        avatarsRef.child(currentUserId).putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                return completion(.failure(error!))
            }
            
            self.avatarsRef.child(self.currentUserId).downloadURL { url, error in
                guard let downloadURL = url else {
                    return completion(.failure(error!))
                }
                completion(.success(downloadURL))
            }
        }
    }
    
    func uploadImageMessage(photo: UIImage, to chat: MChat, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        let uid: String = Auth.auth().currentUser!.uid
        let chatName = [chat.friendUsername, uid].joined()
        
        self.avatarsRef.child(chatName).child(imageName).putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                return completion(.failure(error!))
            }
            self.avatarsRef.child(chatName).child(imageName).downloadURL { url, error in
                guard let downloadURL = url else {
                    return completion(.failure(error!))
                }
                completion(.success(downloadURL))
            }
        }
    }
    
    func downloadImage(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                return completion(.failure(error!))
            }
            completion(.success(UIImage(data: imageData)))
        }
    }
}
