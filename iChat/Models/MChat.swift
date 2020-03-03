//
//  MChat.swift
//  iChat
//
//  Created by Георгий Кашин on 26.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
