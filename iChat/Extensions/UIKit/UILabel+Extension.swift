//
//  UILabel+Extension.swift
//  iChat
//
//  Created by Георгий Кашин on 19.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
