//
//  Network.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/02/17.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import Foundation

//public func sendNoSSLSyncRequest(pURLString:String, pDicBody:NSDictionary?, dataBlock: @escaping(_ bSuccess:Bool, _ errorMsg:String?, _ result:Data?)->Void) -> Void{
//    var request = URLRequest(url: URL(string: pURLString)!)
//
//    let cookies = HTTPCookieStorage.shared.cookies(for: URL(string: pURLString)!)
//    let heasders = HTTPCookie.requestHeaderFields(with: cookies!)
//
//    request.allHTTPHeaderFields = heasders
//    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//    request.httpMethod = "POST"
//
//    if(pDicBody != nil) {
//        let parameterArray : NSMutableArray = NSMutableArray()
//        for (key, value) in pDicBody! {
//            parameterArray.add(String.init(format: "%@=%@", key as! String, (value as! String).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!))
//        }
//        let string = parameterArray.componentsJoined(by: "&")
//        request.httpBody = string.data(using: .utf8)
//    }
//
//    let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
//
//    let dTask = session.dataTask(with: request) { (data, response, error) in
//        if(error != nil) {
//            dataBlock(true, error!.localizedDescription, nil)
//        }else {
//            if(data != nil) {
//                dataBlock(true, nil, data);
//            }else {
//                dataBlock(false, "데이터가 존재하지 않습니다.", nil)
//            }
//        }
//    }
//
//    dTask.resume()
//}
//
//extension CNetwork: URLSessionDelegate {
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        if challenge.previousFailureCount > 0 {
//            completionHandler(.cancelAuthenticationChallenge, nil)
//        }else if let serverTrust = challenge.protectionSpace.serverTrust {
//            completionHandler(.useCredential, URLCredential(trust: serverTrust))
//        }else {
//            print("unknown state. error: \(challenge.error)")
//            completionHandler(.performDefaultHandling, nil)
//        }
//    }
//}



public func sendASyncRequest(pURLString:String, pDicBody:NSDictionary?, dataBlock: @escaping(_ bSuccess:Bool, _ errorMsg:String?, _ result:Data?)->Void) -> Void{
    var request = URLRequest(url: URL(string: pURLString)!)
    
    let cookies = HTTPCookieStorage.shared.cookies(for: URL(string: pURLString)!)
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
    let dTask = session.dataTask(with: request) { (data, response, error) in
        if(error != nil) {
            dataBlock(true, error!.localizedDescription, nil)
        }else {
            if(data != nil) {
                dataBlock(true, nil, data);
            }else {
                dataBlock(false, "데이터가 존재하지 않습니다.", nil)
            }
        }
    }
    
    dTask.resume()
}

public func sendSuhyupRequest(pURLString:String, pDicBody:NSDictionary?, dataBlock: @escaping(_ bSuccess:Bool, _ errorMsg:String?, _ resultCommon:Data?, _ resultBody:Data?)->Void) -> Void{
    var request = URLRequest(url: URL(string: pURLString)!)
    
    let cookies = HTTPCookieStorage.shared.cookies(for: URL(string: pURLString)!)
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
    
    let dTask = session.dataTask(with: request) { (data, response, error) in
        
        if(error != nil) {
            dataBlock(false, error?.localizedDescription, nil, nil)
            return
        }
        
        guard let data = data else {
            dataBlock(false, "데이터가 존재하지 않습니다.", nil, nil)
            return
        }
        
        let result: Dictionary<String, Any>
        let resultMsg : Dictionary<String, Any>
        
        do {
            result = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
//            print("result \(result)")
            resultMsg = result["_msg_"] as! Dictionary<String, Any>
        }catch {
            dataBlock(false, "잘못된 데이터 형식입니다.", nil, nil)
            return
        }
        
        let resultCommon : Dictionary<String, Any> = resultMsg["_common_"] as! Dictionary<String, Any>
        let resultBody : Dictionary<String, Any> = resultMsg["_body_"] as! Dictionary<String, Any>
        
        dataBlock(true, "", resultCommon.dictionaryToData(), resultBody.dictionaryToData())
        
    }
    
    dTask.resume()
}
