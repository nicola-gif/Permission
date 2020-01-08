//
//  PermissionTipable.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation

public protocol PermissionTipable {
    
    /// 标题
    var title: String {get}
    
    /// 描述
    var desc: String {get}
    
    /// 取消这种类型的title
    var cancelActionTitle: String {get}
    
    /// 取消的action
    func cancelAction()
    
    /// ok这种类型的title
    var okActionTitle: String {get}
    
    /// ok的action
    func okAction()
    
    /// 弹出视图的那个控制器
    var presentingVC: UIViewController? {get}
}

public extension PermissionTipable {
    
    var title: String {return "提示"}
    
    var cancelActionTitle: String {return "取消"}
    
    var okActionTitle: String {return "去设置"}
    
    func okAction() {
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    func cancelAction() {}
    
    var presentingVC: UIViewController? {
        guard let rootVC = UIApplication.shared.delegate?.window??.rootViewController else {return nil}
        return findViewController(indexVC: rootVC)
    }
    
    private func findViewController(indexVC: UIViewController?) -> UIViewController? {
        if let tabbarVC = indexVC as? UITabBarController {
            if let presentedVC = tabbarVC.presentedViewController {
                return findViewController(indexVC: presentedVC)
            }
            
            if let selectedVC = tabbarVC.selectedViewController {
                return findViewController(indexVC: selectedVC)
            }
        }
        
        if let navVC = indexVC as? UINavigationController {
            if let presentedVC = navVC.presentedViewController {
                return findViewController(indexVC: presentedVC)
            }
            
            if let topVC = navVC.topViewController {
                return findViewController(indexVC: topVC)
            }
        }
        
        var currentVC = indexVC
        while let tempVC = currentVC?.presentedViewController {
            currentVC = tempVC
        }
        return currentVC
    }
}
