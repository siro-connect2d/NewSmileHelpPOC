//
//  UIApplication+Extensions.swift
//  NewSmileHS
//
//  Created by thang on 23/07/2021.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func topController() -> UIViewController? {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return nil }
        
        if var topController = keyWindow.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return nil
    }
}
