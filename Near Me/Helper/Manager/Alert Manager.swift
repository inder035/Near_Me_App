//
//  Alert Manager.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation
import SwiftEntryKit
import AudioToolbox

class EntryAttributeWrapper {
    var attributes: EKAttributes
    init(with attributes: EKAttributes) {
        self.attributes = attributes
    }
}


class AlertManager {
    static let sheard = AlertManager()
    
    let attributesWrapper: EntryAttributeWrapper = {
        var attributes = EKAttributes()
        attributes = .topFloat
        attributes.displayDuration = 3
        attributes.hapticFeedbackType = .success
        attributes.entryBackground = .visualEffect(style: .dark)
        return EntryAttributeWrapper(with: attributes)
    }()
    
    func showAlert(_ title: String, _ description : String){
        let titleString = EKProperty.LabelContent(text: title, style: EKProperty.LabelStyle(font: UIFont.boldSystemFont(ofSize: 14), color: EKColor.white, alignment: NSTextAlignment.left, displayMode: .light, numberOfLines: 0))
        let descriptionString = EKProperty.LabelContent(text: description, style: EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 14), color: EKColor.white, alignment: NSTextAlignment.left, displayMode: .light, numberOfLines: 0))
        let simpleMessage = EKSimpleMessage(title: titleString,description: descriptionString)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributesWrapper.attributes)
    }
    
//    func showStaticTextAlert(_ txt : AlertTextMessage){
//        let title = EKProperty.LabelContent(text: txt.rawValue, style: EKProperty.LabelStyle(font: UIFont.boldSystemFont(ofSize: 16), color: EKColor.white, alignment: NSTextAlignment.center, displayMode: .light, numberOfLines: 0))
//        let description = EKProperty.LabelContent(text: "", style: EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 1, weight: .light), color: .black ))
//
//        let simpleMessage = EKSimpleMessage(title: title,description: description)
//        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
//        let contentView = EKNotificationMessageView(with: notificationMessage)
//        SwiftEntryKit.display(entry: contentView, using: attributesWrapper.attributes)
//    }
//
//    func alertActionWithButtons(title: String, message: String, actionBlock:@escaping ()->()) {
//        let alert = TYAlertView(title: title, message: message)
//        let alertController = TYAlertController(alert: alert, preferredStyle: .alert, transitionAnimation: .dropDown)
//        alert?.buttonDefaultBgColor = UIColor(named: Color.theme_Purple)
//        alert?.add(TYAlertAction(title: "No", style: .cancel, handler: { (action) in }))
//        alert?.add(TYAlertAction(title: "Yes", style: .default) { (action) in
//            actionBlock()
//        })
//        alert?.clickedAutoHide = true
//        alert?.layer.cornerRadius = 4
//        alert?.alertViewWidth = UIScreen.main.bounds.width - 40
//        alertController?.backgoundTapDismissEnable = false
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertController!, animated: true, completion: nil)
//    }
//
//    func alertActionButton(title: String, message: String, actionBlock:@escaping ()->()) {
//        let alert = TYAlertView(title: title, message: message)
//        let alertController = TYAlertController(alert: alert, preferredStyle: .alert, transitionAnimation: .dropDown)
//        alert?.buttonDefaultBgColor = UIColor(named: Color.theme_Purple)
//        alert?.add(TYAlertAction(title: "OK", style: .default) { (action) in
//            actionBlock()
//        })
//        alert?.clickedAutoHide = true
//        alert?.layer.cornerRadius = 4
//        alert?.alertViewWidth = UIScreen.main.bounds.width - 40
//        alertController?.backgoundTapDismissEnable = false
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertController!, animated: true, completion: nil)
//    }
//
//    func alertActionButtonTitle(title: String, message: String, btnTitle: String, actionBlock:@escaping ()->()) {
//        let alert = TYAlertView(title: title, message: message)
//        let alertController = TYAlertController(alert: alert, preferredStyle: .alert, transitionAnimation: .dropDown)
//        alert?.buttonDefaultBgColor = UIColor(named: Color.theme_Purple)
//        alert?.add(TYAlertAction(title: btnTitle, style: .default) { (action) in
//            actionBlock()
//        })
//        alert?.clickedAutoHide = true
//        alert?.layer.cornerRadius = 4
//        alert?.alertViewWidth = UIScreen.main.bounds.width - 40
//        alertController?.backgoundTapDismissEnable = false
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertController!, animated: true, completion: nil)
//    }
}
