//
//  UIApplication+Extension.swift
//  iChat
//
//  Created by Георгий Кашин on 02.03.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import UIKit

extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
