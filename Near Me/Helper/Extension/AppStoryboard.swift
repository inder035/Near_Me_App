///
//  ViewExtension.swift
//  Near Me
//
//  Created by Inder Singh on 25/06/22.
//

import UIKit

enum AppStoryboard : String {
    case Main = "Main"

    var instance: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass : T.Type) -> T{
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController?{
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard: AppStoryboard) -> Self{
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func popToViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
