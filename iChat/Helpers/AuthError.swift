//
//  AuthError.swift
//  iChat
//
//  Created by Георгий Кашин on 28.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case serverError
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Invalid email format", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Passwords don't match", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
