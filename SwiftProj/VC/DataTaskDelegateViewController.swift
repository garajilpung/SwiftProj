//
//  DataTaskDelegateViewController.swift
//  SwiftProj
//
//  Created by finger on 2023/11/14.
//  Copyright © 2023 garajilpung. All rights reserved.
//

import UIKit

@objc(DataTaskDelegateViewController)
class DataTaskDelegateViewController: BasicViewController {

    var session : URLSession = URLSession()
    var dtDownlad : URLSessionDataTask = URLSessionDataTask()
    var rcData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onBtnStart2(_ sender: Any) {
        
        var req = URLRequest(url: URL(string: "https://garajilpung.synology.me/test/aa.txt")!)
        req.httpMethod = "GET"
        
        if #available(iOS 13.0, *) {
            session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        } else {
            session = URLSession(configuration: URLSessionConfiguration(), delegate: self, delegateQueue: nil)
        }
        dtDownlad = session.dataTask(with: req)
        print("dtDownlad id \(dtDownlad.taskIdentifier)")
        
        rcData = Data()
        dtDownlad.resume()
    }
    
    @IBAction func onBtnStart(_ sender: Any) {
        
        var req1 = URLRequest(url: URL(string: "https:/down.finger.co.kr/down/mws/big/service/bigcore")!)
        req1.httpMethod = "GET"

        URLSession.shared.dataTask(with: req1) { (data, response, error)in
            
            if (error == nil) {
                print("url \(String(describing: req1.url?.absoluteString)) size [\(String(describing: data?.count))]")
                
//                let coreDe = ObjCFunc.aes128Decrypt(withKey: "com.mwsniper", encData: data!)
//                
//                if coreDe.count != 0 {
//                    let coreString = String(data: coreDe, encoding: .utf8)
//                    
//                    print("url \(String(describing: req1.url?.absoluteString)) size [\(String(describing: coreString!.count))]")
//                }
            }
            
        }.resume()
        
        var req2 = URLRequest(url: URL(string: "https:/down.finger.co.kr/down/mws/big/service/bigpki")!)
        req2.httpMethod = "GET"

        URLSession.shared.dataTask(with: req2) { (data, response, error)in
            
            if (error == nil) {
                print("url \(String(describing: req2.url?.absoluteString)) size [\(String(describing: data?.count))]")
            }
            
//            let coreDe = ObjCFunc.aes128Decrypt(withKey: "com.mwsniper", encData: data!)
//
//            if coreDe.count != 0 {
//                let coreString = String(data: coreDe, encoding: .utf8)
//
//                print("url \(String(describing: req1.url?.absoluteString)) size [\(String(describing: coreString!.count))]")
//            }
            
        }.resume()
        
        var req3 = URLRequest(url: URL(string: "https:/down.finger.co.kr/down/mws/big/service/bigcommon")!)
        req3.httpMethod = "GET"

        URLSession.shared.dataTask(with: req3) { (data, response, error)in
            
            if (error == nil) {
                print("url \(String(describing: req3.url?.absoluteString)) size [\(String(describing: data?.count))]")
            }
            
//            let coreDe = ObjCFunc.aes128Decrypt(withKey: "com.mwsniper", encData: data!)
//
//            if coreDe.count != 0 {
//                let coreString = String(data: coreDe, encoding: .utf8)
//
//                print("url \(String(describing: req1.url?.absoluteString)) size [\(String(describing: coreString!.count))]")
//            }
            
        }.resume()
    }
    
}

extension  DataTaskDelegateViewController : URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        rcData.append(data)
        
        print("data length \(rcData.count)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("error \(error.localizedDescription)")
        } else {
            
        }
    }
}
