//
//  AppDelegate.swift
//  SwiftProj
//
//  Created by garajilpung on 11/02/2020.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

/*
 @UIApplicationMain 제거하면 예전의 main.m 를 추가할 수 있다.
 swift 이므로 main.swift로 선언하고 추가하면 된다.
 */
//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        #if DEBUG
            DFT_TRACE_PRINT(output: "Debug")
        #else
            DFT_TRACE_PRINT(output: "Release")
        #endif
        
        
        #if TARGET_OS_SIMULATOR
            print("simulator 일단만 작동")
        #else
            print("device 일단만 작동")
        #endif
        
        ObjCFunc.log_ObjC("vkdikm")
        
        let objC = ObjCFunc.init()
        
        objC.aStr = "vwer"
        
        DFT_TRACE_PRINT(output: "vvv \(objC.aStr)")
        
        print("device \(UIDevice.current.modelName)")
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

    
    
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return  [.portrait, .landscape]
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // UIApplcation.shared.registerForRemoteNotifications() 호춠 후 APNS 등록 시 호출됨

    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // UIApplcation.shared.registerForRemoteNotifications() 호춠 후 APNS 등록 실패 시 호출됨
    }
    
    
        
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //  UIApplication.shared.open(
        
        return true
    }
    
    // 백그라운드에서 숏컷(Quick action)이 들어 올경우
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
    }
}

