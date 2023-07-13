//
//  CallAppShemeViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/06/30.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(CallAppShemeViewController)
class CallAppShemeViewController: BasicViewController {

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

    @IBAction func onBtnTel(_ sender: Any) {
        UIApplication.shared.open(URL(string: "tel://01086415524")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "tel open success")
            }else {
                DFT_TRACE_PRINT(output: "tel open fail")
            }
            
        }
    }
    
    @IBAction func onBtnSMS(_ sender: Any) {
        UIApplication.shared.open(URL(string: "sms://01086415524")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "sms open success")
            }else {
                DFT_TRACE_PRINT(output: "sms open fail")
            }
            
        }
    }
    
    @IBAction func onBtnMail(_ sender: Any) {
        UIApplication.shared.open(URL(string: "mailto://ksos73@nate.com")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "mail open success")
            }else {
                DFT_TRACE_PRINT(output: "mail open fail")
            }
            
        }
    }
    
    @IBAction func onBtnSafari(_ sender: Any) {
//        UIApplication.shared.open(URL(string: "http://m.google.com")!)
//        UIApplication.shared.open(URL(string: "https://m.google.com"))
        
//        UIApplication.shared.open(URL(string: "http://m.google.com")!, options: [:]) { ret in
            
        UIApplication.shared.open(URL(string: "https://m.google.com")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "safari open success")
            }else {
                DFT_TRACE_PRINT(output: "safari open fail")
            }
            
        }
    }
    
    @IBAction func onBtnFaceTime(_ sender: Any) {
        //전화번호 이외 메일 주소도 가능하다고 함
        UIApplication.shared.open(URL(string: "facetime://01086415524")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "facetime open success")
            }else {
                DFT_TRACE_PRINT(output: "facetime open fail")
            }
            
        }
    }
    
    @IBAction func onBtnFaceTimeAudio(_ sender: Any) {
        //전화번호 이외 메일 주소도 가능하다고 함
        UIApplication.shared.open(URL(string: "facetime-audio://01086415524")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "facetime-audio open success")
            }else {
                DFT_TRACE_PRINT(output: "facetime-audio open fail")
            }
            
        }
    }
    
    @IBAction func onBtnMaps(_ sender: Any) {
        // 주소는 검색어 또는 위도와 경도로도 가능하다.
        // http://maps.apple.com/?q=Mexican+Restaurant&sll=50.894967,4.341626&z=10&t=s
        
        UIApplication.shared.open(URL(string: "http://maps.apple.com/?q=Mexican+Restaurant")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "maps open success")
            }else {
                DFT_TRACE_PRINT(output: "maps open fail")
            }
            
        }
    }
    
    @IBAction func onBtnAppStore(_ sender: Any) {
        UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/app/id361304891")!, options: [:]) { ret in
            
            if(ret) {
                DFT_TRACE_PRINT(output: "maps open success")
            }else {
                DFT_TRACE_PRINT(output: "maps open fail")
            }
            
        }
    }
    
    @IBAction func onBtnAppCall(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "smgsgim://sswd.dkovm.dkowk")!, options: [:])
        
        
//        UIApplication.shared.open(URL(string: "smgsgim://sswd.dkovm.dkowk")!, options: [:]) { ret in
//            
//            if(ret) {
//                DFT_TRACE_PRINT(output: "smgsgim open success")
//            }else {
//                DFT_TRACE_PRINT(output: "smgsgim open fail")
//            }
//            
//        }
    }
}
