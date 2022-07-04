//
//  Indicator.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Indicator: UIViewController,NVActivityIndicatorViewable{
    let size = CGSize(width:50, height: 50)
    static let shared = Indicator()
    
    
    func start(){
        startAnimating(size,message:"",type:NVActivityIndicatorType.ballRotateChase, color: .themeColor())
    }
    
    func stop(){
        stopAnimating()
    }
}

