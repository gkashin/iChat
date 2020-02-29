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
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "")
        case .photoNotExist:
            return NSLocalizedString("User didn't choose the photo", comment: "") 
        }
    }
}
