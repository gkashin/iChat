//
//  MChat.swift
//  iChat
//
//  Created by Георгий Кашин on 26.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import FirebaseFirestore
import UIKit

struct MChat: Hashable, Decodable {
    var friendId: String
    var friendUsername: String
    var friendImageName: String
    var lastMessageContent: String
    
    var representation: [String: Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendImageName"] = friendImageName
        rep["lastMessage"] = lastMessageContent
        rep["friendId"] = friendId 
        return rep
    }
    
    init(friendId: String, friendUsername: String, friendImageName: String, lastMessageContent: String) {
        self.friendId = friendId
        self.friendUsername = friendUsername
        self.friendImageName = friendImageName
        self.lastMessageContent = lastMessageContent
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendId = data["friendId"] as? String,
        let friendUsername = data["friendUsername"] as? String,
        let friendImageName = data["friendImageName"] as? String,
        let lastMessageContent = data["lastMessage"] as? String else { return nil }
        
        self.friendId = friendId
        self.friendImageName = friendImageName
        self.friendUsername = friendUsername
        self.lastMessageContent = lastMessageContent
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
