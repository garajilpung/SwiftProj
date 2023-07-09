//
//  MemoryLeakViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/12/21.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit
import WebKit

@objc(MemoryLeakViewController)
class MemoryLeakViewController: UIViewController {

    private var webview : WKWebView?
    
    public var vStr : String = ""
    
    @IBOutlet weak var vWBack: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        webview = WKWebView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        guard let vWeb = webview else {
            return
        }
        
        vWBack.addSubview(vWeb)
        
        vWeb.load(URLRequest.init(url: URL(string: "https://m.naver.com")!))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UIButton Event
    @IBAction func onBtn1(_ sender: Any) {
        let vc = MemoryLeakViewController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true) {
            
        }
    }
    
    @IBAction func onBtn2(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func onBtn3(_ sender: Any) {
        let vc = MemoryLeakViewController()
        
        vc.vStr = "vvwe";
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onBtn4(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    DispatchQueue.main.async(execute: {
//            self.webView.evaluateJavaScript(js, completionHandler: { (_, error) -> Void in
//                if let error = error {
//                    self.codeGenerationFailed("An error occurred generating code: \(error)")
//                }
//        })
}
