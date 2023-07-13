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
        
//        Utility.increaseBadge()
        
        // Push 관련 delegate 함수 연결
//        registerForRemoteNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification , object: nil)
        return true
    }

    // 아래의 함수 중 sceneDelegate가 대응되는 함수가 존재하면 sceneDelegate의 함수가 먼저 호출됨을 유념한다.
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

    
    
    // 이게 반응이 기기 종류에 따라 다르다.
    // iPad의 경우 info.plist 에 있는 값을 따르고
    // iPhone의 경우 아래의 함수가 있는 경우 아래의 함수를 따르고 없으면 info.plist에 있는 값을 따른다.
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

//        return  [.portrait, .landscape]
        return  [.portrait]
    }
    
    // MARK: Noti orientation
    @objc func deviceOrientationDidChange() {
        //회전 문제
        // iPad의 경우 회전시 screen size를 가져오면 가로 세로가 뒤바뀌어 있다.
        // iPhone의 경우에는 문제없이 가로 세로 값을 가져온다.
        
        if isPad() {
            // 즉 아이패드의 경우 화면 사이즈 회전상태값이 반대로 찍힌다.
            // 물론 이것은 예전에도 그런 것 같지만 이렇게 강제로 고정하는게 맞는 것인지 참 알수가 없네
            // 근데 문제는 180 회전을 하면 이때는 또 값이 맞게 나온다. 그러니 값이 크기를 측정하여 강제로 고정 시켜야 할 것 같다.
            // 참 소스가 지저분해 지는데
            
            if (UIDevice.current.orientation.isLandscape) {
                if(UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height) {
                    GlobalData.sharedInstance.screenHeight = UIScreen.main.bounds.size.height
                    GlobalData.sharedInstance.screenWidth = UIScreen.main.bounds.size.width
                }else {
                    GlobalData.sharedInstance.screenHeight = UIScreen.main.bounds.size.width
                    GlobalData.sharedInstance.screenWidth = UIScreen.main.bounds.size.height
                }
            }else {
                if(UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height) {
                    GlobalData.sharedInstance.screenHeight = UIScreen.main.bounds.size.width
                    GlobalData.sharedInstance.screenWidth = UIScreen.main.bounds.size.height
                }else {
                    GlobalData.sharedInstance.screenHeight = UIScreen.main.bounds.size.height
                    GlobalData.sharedInstance.screenWidth = UIScreen.main.bounds.size.width
                }
            }

        }else {

        }
        
//        DFT_TRACE_PRINT(output: "\(UIScreen.main.bounds.size.width)],[\(UIScreen.main.bounds.size.height)")
    }
    
    // Push
    private func registerForRemoteNotifications() {

        // 1. 푸시 center (유저에게 권한 요청 용도)
        let center = UNUserNotificationCenter.current()
        center.delegate = self // push처리에 대한 delegate - UNUserNotificationCenterDelegate
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (granted, error) in

            guard granted else {
                return
            }

//            아래 구문을 실행하여 실제로 등록되기에 따로 빼놓다.
//            DispatchQueue.main.async {
//                // 2. APNs에 디바이스 토큰 등록
//                UIApplication.shared.registerForRemoteNotifications()
//            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // UIApplcation.shared.registerForRemoteNotifications() 호춠 후 APNS 등록 시 호출됨

    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // UIApplcation.shared.registerForRemoteNotifications() 호춠 후 APNS 등록 실패 시 호출됨
    }
    
    
    // openURL
    // sceneDelegate 가 추가 되어 있으면 sceneDelegate의 scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) 가 호출 된다.
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //  UIApplication.shared.open(
        
        return true
    }
    
    // 백그라운드에서 숏컷(Quick action)이 들어 올경우
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // 앱이 foreground상태 일 때, 알림이 온 경우 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        // 푸시가 오면 alert, badge, sound표시를 하라는 의미
        completionHandler([.alert, .badge, .sound])
    }

    // Push에 의해 앱이 기동되는 경우(앱 종료된 상태이거나, 앱이 백그라운드인 경우)
    // push가 온 경우 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        // deep link처리 시 아래 url값 가지고 처리
        let url = response.notification.request.content.userInfo
        print("url = \(url)")

        // if url.containts("receipt")...
    }
}
