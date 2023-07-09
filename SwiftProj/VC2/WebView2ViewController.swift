//
//  WebView2ViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/12/23.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit
import WebKit

class WebView2ViewController: UIViewController {

    @IBOutlet weak var web: WKWebView!
    
    public var urlMenu : String? = "m.naver.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://m.naver.com")
        
        web.load(URLRequest(url: url!))
        
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
    
    @IBAction func onBtn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "navi2VC")
        
        guard let keyWindow = UIWindow.key else {
            return
        }
        
        keyWindow.rootViewController = vc
    }
}
