//
//  MMessage.swift
//  iChat
//
//  Created by Георгий Кашин on 03.03.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import UIKit

struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUsername: String
    let sentDate: Date
    let id: String?
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderId": senderId,
            "senderName": senderUsername,
            "content": content,
        ]
        return rep
    }
    
    init(user: MUser, content: String) {
        self.content = content 
        senderId = user.id
        senderUsername = user.username
        sentDate = Date()
        id = nil
    }
}
