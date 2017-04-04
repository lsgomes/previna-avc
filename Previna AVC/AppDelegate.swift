//
//  AppDelegate.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        // handle the iOS bar!
        
        // >>>>>NOTE<<<<<
        // >>>>>NOTE<<<<<
        // >>>>>NOTE<<<<<
        // "Status Bar Style" refers to the >>>>>color of the TEXT<<<<<< of the Apple status bar,
        // it does NOT refer to the background color of the bar. This causes a lot of confusion.
        // >>>>>NOTE<<<<<
        // >>>>>NOTE<<<<<
        // >>>>>NOTE<<<<<
        
        // our app is white, so we want the Apple bar to be white (with, obviously, black writing)
        
        // make the ultimate window of OUR app actually start only BELOW Apple's bar....
        // so, in storyboard, never think about the issue. design to the full height in storyboard.
        //let h = UIApplication.shared.statusBarFrame.size.height
        //let f = self.window?.frame
        //self.window?.frame = CGRect(x: 0, y: h, width: f!.size.width, height: f!.size.height - h)
        
        // next, in your plist be sure to have this: you almost always want this anyway:
        // <key>UIViewControllerBasedStatusBarAppearance</key>
        // <false/>
        
        // next - very simply in the app Target, select "Status Bar Style" to Default.
        // Do nothing in the plist regarding "Status Bar Style" - in modern Xcode, setting
        // the "Status Bar Style" toggle simply sets the plist for you.
        
        // finally, method A:
        // set the bg of the Apple bar to white.  Technique courtesy Warif Akhand Rishi.
        // note: self.window?.clipsToBounds = true-or-false, makes no difference in method A.
        //if let sb = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            //sb.backgroundColor = UIColor.white
            // if you prefer a light gray under there...
            //sb.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.9, alpha: 1)
            //sb.backgroundColor = UIColor.lightGray
        //}
        
        /*
         // if you prefer or if necessary, method B:
         // explicitly actually add a background, in our app, to sit behind the apple bar....
         self.window?.clipsToBounds = false // MUST be false if you use this approach
         let whiteness = UIView()
         whiteness.frame = CGRect(x: 0, y: -h, width: f!.size.width, height: h)
         whiteness.backgroundColor = UIColor.green
         self.window!.addSubview(whiteness)
         */

        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert , .badge , .sound], categories: nil))
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

