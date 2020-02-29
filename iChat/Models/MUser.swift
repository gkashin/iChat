//
//  MUser.swift
//  iChat
//
//  Created by Георгий Кашин on 26.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import UIKit

struct MUser: Hashable, Decodable {
    var id: String
    var email: String
    var username: String
    var imageName: String
    var description: String
    var sex: String
    
    var representation: [String: Any] {
        var rep = ["uid": id]
        rep["email"] = email
        rep["username"] = username
        rep["imageName"] = imageName
        rep["description"] = description
        rep["sex"] = sex
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
