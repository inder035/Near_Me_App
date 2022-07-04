//
//  ColorExtension.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import UIKit

extension UIColor{
    class func themeColor() -> UIColor{
        return UIColor(named: "Theme_Color") ?? .red
    }
    
    class func themeWhite() -> UIColor{
        return UIColor(named: "Theme_White") ?? .red
    }
    
    class func themeBlack() -> UIColor{
        return UIColor(named: "Theme_Black") ?? .red
    }
    
    class func themeGray() -> UIColor{
        return UIColor(named: "Theme_Gray") ?? .red
    }
}
