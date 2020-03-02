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
}
