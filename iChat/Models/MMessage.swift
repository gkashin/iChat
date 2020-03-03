//
//  MMessage.swift
//  iChat
//
//  Created by Георгий Кашин on 03.03.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import FirebaseFirestore
import UIKit

struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUsername: String
    let sentDate: Date
    let id: String?
    
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderId": senderId,
            "senderName": senderUsername,
            "content": content,
        ]
        return rep
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderId"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.senderId = senderId
        self.senderUsername = senderName
        self.content = content
    }
    
    init(user: MUser, content: String) {
        self.content = content 
        senderId = user.id
        senderUsername = user.username
        sentDate = Date()
        id = nil
    }
}
