//
//  Utility.swift
//  NewSmileHS
//
//  Created by thang on 23/07/2021.
//

import UIKit
import MBProgressHUD

class Utility: NSObject {
    
    static func hasConnection() -> Bool {
        let reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
        let status = reachability?.currentReachabilityStatus()
        return status != NetworkStatus.NotReachable
    }
    
    static func performOnMainThread(_ closure: @escaping () -> Void) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async {
                closure()
            }
        }
    }
    
    //Show/Hide loading
    static func showHUD(in view: UIView, _ animated: Bool = true) {
        Utility.performOnMainThread {
            MBProgressHUD.showAdded(to: view, animated: animated)
        }
    }
    
    static func hideHUD(in view: UIView, _ animated: Bool = true) {
        Utility.performOnMainThread {
            MBProgressHUD.hide(for: view, animated: animated)
        }
    }
}

