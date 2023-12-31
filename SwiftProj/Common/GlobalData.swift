//
//  GlobalData.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/23.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import WebKit

class GlobalData {

//    static let sharedInstance = GlobalData()

    private struct Static {
        static var instance : GlobalData?
    }
    
    class var sharedInstance : GlobalData {
        if Static.instance == nil {
            Static.instance = GlobalData()
        }
        
        return Static.instance!
    }
    
    class func destroySharedInstance() {
        Static.instance = nil
    }
    
    var screenWidth : CGFloat = UIScreen.main.bounds.size.width
    var screenHeight : CGFloat = UIScreen.main.bounds.size.height
    
    var appVersion : String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else { return nil }

        return version
    }
    
    var buildVersion : String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let build = dictionary["CFBundleVersion"] as? String else { return nil }

        return build
    }
    
    let osVersion : String = UIDevice.current.systemVersion
        
    var dataCookie : Array<HTTPCookie>?
    
    // 각각의 위치에서 쿠키값을 가져온다.
    // 0 이면 NSHTTPCookieStorage
    // 1 이면 WKWebsiteDataStore 에서
    func getCookie(type:Int) -> Void {
        if(type == 0) {
            print("cookie ", HTTPCookieStorage.shared.cookies as Any)
            dataCookie = HTTPCookieStorage.shared.cookies
        }else if(type == 1){
            WKWebsiteDataStore.default().httpCookieStore.getAllCookies { (result) in
                print("cookie ", result)
                self.dataCookie = result
            }
        }
    }
    
}
