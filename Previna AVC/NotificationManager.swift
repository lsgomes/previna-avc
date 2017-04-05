//
//  NotificationManager.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/3/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import Foundation
import UIKit

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func checkNotificationEnabled() -> Bool {
        // Check if the user has enabled notifications for this app and return True / False
        guard let settings = UIApplication.shared.currentUserNotificationSettings else { return false }
        if settings.types == .none {
            return false
        } else {
            return true
        }
    }
    
    func checkNotificationExists(taskTypeId: String) -> Bool {
        // Loop through the pending notifications
        for notification in UIApplication.shared.scheduledLocalNotifications! as [UILocalNotification] {
            
            // Find the notification that corresponds to this task entry instance (matched by taskTypeId)
            if (notification.userInfo!["taskObjectId"] as? String == String(taskTypeId)) {
                return true
            }
        }
        return false
        
    }
    
    func scheduleNotification(minutes: Int, taskTypeId: String, viewController: UIViewController) {
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: minutes, to: Date())
        
        scheduleNotification(taskTypeId: taskTypeId, alertDate: date!, viewController: viewController)
    }
    
    func scheduleNotification(taskTypeId: String, alertDate: Date, viewController: UIViewController) {
        
        if (!checkNotificationEnabled()) {
            displayNotificationsDisabled(viewController: viewController)
        }
        
        let notification = UILocalNotification()
        notification.fireDate = alertDate
        notification.alertBody = "Task \(taskTypeId)"
        notification.alertAction = "Due : \(alertDate)"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["taskObjectId": taskTypeId]
        UIApplication.shared.scheduleLocalNotification(notification)
        
        print("Notification set for taskTypeID: \(taskTypeId) at \(alertDate)")
    }
    
    private func displayNotificationsDisabled(viewController: UIViewController) {
        
        displayAlert(title: "Notificações desabilitadas para o aplicativo Previna AVC", message: "Por favor, habilite as notificações em Ajustes -> Notificações -> Previna AVC", dismiss: "FECHAR", viewController: viewController)
    }
    
    public func displayAlert(title: String, message: String, dismiss: String, viewController: UIViewController) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(
            title: dismiss,
            style: UIAlertActionStyle.default,
            handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func removeNotification(taskTypeId: String) {
        
        // loop through the pending notifications
        for notification in UIApplication.shared.scheduledLocalNotifications! as [UILocalNotification] {
            
            // Cancel the notification that corresponds to this task entry instance (matched by taskTypeId)
            if (notification.userInfo!["taskObjectId"] as? String == String(taskTypeId)) {
                UIApplication.shared.cancelLocalNotification(notification)
                
                print("Notification deleted for taskTypeID: \(taskTypeId)")
                
                break
            }
        }
    }
    
    func listNotifications() -> [UILocalNotification] {
        var localNotify: [UILocalNotification]?
        for notification in UIApplication.shared.scheduledLocalNotifications! as [UILocalNotification] {
            localNotify?.append(notification)
        }
        return localNotify!
    }
    
    func printNotifications() {
        
        print("List of notifications currently set:- ")
        
        for notification in UIApplication.shared.scheduledLocalNotifications! as [UILocalNotification] {
            print ("\(notification)")
        }
    }


}
