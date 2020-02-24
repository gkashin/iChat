//
//  UIStackView+Extension.swift
//  iChat
//
//  Created by Георгий Кашин on 19.02.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
