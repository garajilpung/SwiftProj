//
//  Utility.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/23.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import Foundation

// 콘솔 출력용
public func DFT_TRACE(filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
    Swift.print("\(filename)[\(funcname)][Line \(line)]")
    #endif
    
}

// Special Literal
//#file, #line, #function 등
public func DFT_TRACE_PRINT(filename: String = #file, line: Int = #line, funcname: String = #function, output:Any...) {
    #if DEBUG
    let now = NSDate()

//    let functionName = funcname.components(separatedBy: "(").first ?? "NotFunc"
    let fileName = (filename as NSString).lastPathComponent
//    let fileName = filename.components(separatedBy: "/").last ?? "NotFile"
    
    Swift.print("[\(now.description)][\(fileName)][\(funcname)][Line \(line)] \(output)")
    #endif
}

public func print(_ object:Any...) {
    #if DEBUG
    for item in object {
        Swift.print(item)
    }
    #endif
}

public func print(_ object:Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}

public func hasJailbreak() -> Bool {
    
    guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else { return false }
    if UIApplication.shared.canOpenURL(cydiaUrlScheme as URL) {
        return true
    }
    #if arch(i386) || arch(x86_64)
    return false
    #endif
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
        fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
        fileManager.fileExists(atPath: "/bin/bash") ||
        fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
        fileManager.fileExists(atPath: "/etc/apt") ||
        fileManager.fileExists(atPath: "/usr/bin/ssh") ||
        fileManager.fileExists(atPath: "/private/var/lib/apt") {
        return true
    }
    if canOpen(path: "/Applications/Cydia.app") ||
        canOpen(path: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
        canOpen(path: "/bin/bash") ||
        canOpen(path: "/usr/sbin/sshd") ||
        canOpen(path: "/etc/apt") ||
        canOpen(path: "/usr/bin/ssh") {
        return true
    }
    let path = "/private/" + NSUUID().uuidString
    do {
        try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        try fileManager.removeItem(atPath: path)
        return true
    } catch {
        return false
    }
}

public func canOpen(path: String) -> Bool {
    let file = fopen(path, "r")
    guard file != nil else { return false }
    fclose(file)
    return true
}

public func startLoading() {
    guard let view = UIWindow.key?.viewWithTag(8888) else {
        DFT_TRACE_PRINT(output: "Loading Image not load")
        return
    }
    
    view.isHidden = false
    
}

public func stopLoading() {
    guard let view = UIWindow.key?.viewWithTag(8888) else {
        DFT_TRACE_PRINT(output: "Loading Image not load")
        return
    }
    
    view.isHidden = true
}

public func isPad() -> Bool{
    var ret = false
    
    if (UIDevice.current.userInterfaceIdiom == .pad) {
        ret = true
    }else {
        ret = false
    }
    
    return ret
}

class Utility {

    
    // MARK: - KeyChain
    func showKeyCahin(keyName:String, groupName:String) {
        
    }
    
    func deleteAllKeyCahin() {
        
    }
    
    func deleteKeyChain(keyName:String, groupName:String) {
        
    }
    
    
    // MARK: - Etc
    func topViewController()->UIViewController {
        
        return UIViewController.init()
    }
    
    func getASCIICode(str:String) ->String {
        return "getAscii"
    }
    
    func getUUID()-> String{
        return "UUID"
    }
    
    func getDevice() {
        
    }
    
    func saveShareDataKey(key:String, data:String) {
        
    }
    
    func loadShareDataKey(key:String) -> String {
        
        return "shareData"
    }
 
    // savedata 초기화
    static func setUserDefaults() -> Void {
        
    }
    
    // 호스트 처리
    static func getHost() -> String {
        var ret = "https://garajilpung.synology.me"
        
        let bServerPosition = UserDefaults.standard.bool(forKey: SaveKeyName.serverposition.rawValue)
        
        if(!bServerPosition) {
            ret = "http://192.168.1.103"
        }
        
        return ret
    }
    
    
    // BlockCoding
    static func loadAsyncImageFromURL(pURL:URL, imageBlock: @escaping(UIImage) -> Void, errorBlock: @escaping()->Void ) -> Void {
    
        DispatchQueue.global().async {
            do {
                let data = try Data.init(contentsOf: pURL)
                let img = UIImage.init(data: data)

                DispatchQueue.main.async{
                    if(img != nil) {
                        imageBlock(img!)
                    }else {
                        errorBlock()
                    }
                }
            }catch {
                
            }
        }
    }
    
    static func sendASyncRequest(pURL:String, pDicBody:NSDictionary?, dataBlock: @escaping(_ bSuccess:Bool, _ errorMsg:String?, _ result:String?)->Void) -> Void{
        let request = NSMutableURLRequest(url: URL(string: pURL)!)
        
        let cookies = HTTPCookieStorage.shared.cookies(for: URL(string: pURL)!)
        let heasders = HTTPCookie.requestHeaderFields(with: cookies!)
        
        request.allHTTPHeaderFields = heasders
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        if(pDicBody != nil) {
            let parameterArray : NSMutableArray = NSMutableArray()
            for (key, value) in pDicBody! {
                parameterArray.add(String.init(format: "%@=%@", key as! String, (value as! String).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!))
            }
            let string = parameterArray.componentsJoined(by: "&")
            request.httpBody = string.data(using: .utf8)
        }
        
        let session = URLSession.shared
        
        let dTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if(error != nil) {
                dataBlock(true, error!.localizedDescription, nil)
            }else {
                if(data != nil) {
                    dataBlock(true, nil, String.init(data: data!, encoding: .utf8) );
                }else {
                    dataBlock(false, "데이터가 존재하지 않습니다.", nil)
                }
            }
        }
        
        dTask.resume()
    }
    
//    static func getNetworkType()->String {
//        let reachability = Reachability.reachabilityForInternetConnection()
//
//
//    }
    
    // setUserAgent
    static public func userAgentInit() {
        
        let dic = ["UserAgent" : "Utility UserAgent Init"]

        UserDefaults.standard.register(defaults: dic)
        
    }
    
    // badgeCount Add
    static public func increaseBadge() {
        //ASPN 사용했을 때만 사용 가능하다.
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
    }
    
    static public func initBadge() {
        //ASPN 사용했을 때만 사용 가능하다.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}


