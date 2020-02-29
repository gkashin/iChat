//
//  UserError.swift
//  iChat
//
//  Created by Георгий Кашин on 29.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotGetUserInfo
    case cannotUnwrapToMUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "")
        case .photoNotExist:
            return NSLocalizedString("User didn't choose the photo", comment: "") 
        case .cannotGetUserInfo:
            return NSLocalizedString("It's impossible to get the data about User from Firebase", comment: "") 
        case .cannotUnwrapToMUser:
            return NSLocalizedString("It's impossible to convert MUser from User", comment: "")
        }
    }
}
