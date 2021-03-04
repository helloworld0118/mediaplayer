//
//  AppDelegate.swift
//  player
//
//  Created by bing.wang on 15/1/7.
//  Copyright (c) 2015年 devil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /*
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
        settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
        categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];

        */
        
       return true
    }
    func application(application: UIApplication , didReceiveRemoteNotification userInfo: [ NSObject : AnyObject ], fetchCompletionHandler completionHandler: ( UIBackgroundFetchResult ) -> Void ) {
        let notif    = userInfo as NSDictionary
        
        let apsDic   = notif.objectForKey ( "aps" ) as! NSDictionary
        
        let alertDic = apsDic.objectForKey ( "alert" ) as! String
        
        var alertView = UIAlertView (title: " 远程推送通知 " , message: alertDic, delegate: nil , cancelButtonTitle: " 返回 " )
        
        alertView.show ()
    
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
    }
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError!) {
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       
        let isPatternSet = (NSUserDefaults.standardUserDefaults().valueForKey("KeyForCurrentPatternToUnlock") != nil) ? true:false
        if self.window?.rootViewController?.parentViewController == nil && isPatternSet {
            let lockVc=TestViewController()
            lockVc.infoLabelStatus = InfoStatusNormal
            self.window?.rootViewController?.presentViewController(lockVc, animated: false, completion: nil)
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

