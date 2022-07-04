///
//  ViewExtension.swift
//  Near Me
//
//  Created by Inder Singh on 25/06/22.
//

import UIKit

extension UIApplication {
    
    class var appWindow: UIWindow! {
        return (UIApplication.shared.keyWindow!)
    }
    
    class var rootViewController: UIViewController! {
        return self.appWindow.rootViewController!
    }
    
    class var visibleViewController: UIViewController! {
        return self.rootViewController.findContentViewControllerRecursively()
    }
    
    class var visibleNavigationController: UINavigationController! {
        return self.visibleViewController.navigationController!
    }
}

extension UIViewController{
    func findContentViewControllerRecursively() -> UIViewController {
        var childViewController: UIViewController?
        if (self is UITabBarController) {
            childViewController = (self as? UITabBarController)?.selectedViewController
        }
        else if (self is UINavigationController) {
            childViewController = (self as? UINavigationController)?.topViewController
        }
        else if (self is UISplitViewController) {
            childViewController = (self as? UISplitViewController)?.viewControllers.last
        }
        else if (self.presentedViewController != nil) {
            childViewController = self.presentedViewController
        }
        let shouldContinueSearch: Bool = (childViewController != nil) && !((childViewController?.isKind(of: UIAlertController.self))!)
        return shouldContinueSearch ? childViewController!.findContentViewControllerRecursively() : self
    }
}




