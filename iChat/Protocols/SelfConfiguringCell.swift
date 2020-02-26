//
//  SelfConfiguringCell.swift
//  iChat
//
//  Created by Георгий Кашин on 25.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
