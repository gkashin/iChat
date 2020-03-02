//
//  MUser.swift
//  iChat
//
//  Created by Георгий Кашин on 26.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import FirebaseFirestore
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
    
    init(id: String, email: String, username: String, imageName: String, description: String, sex: String) {
        self.id = id
        self.email = email
        self.username = username
        self.imageName = imageName
        self.description = description
        self.sex = sex
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let id = data["uid"] as? String,
            let email = data["email"] as? String,
            let username = data["username"] as? String,
            let imageName = data["imageName"] as? String,
            let description = data["description"] as? String,
            let sex = data["sex"] as? String else { return nil }
        
        self.id = id
        self.email = email
        self.username = username
        self.imageName = imageName
        self.description = description
        self.sex = sex
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
