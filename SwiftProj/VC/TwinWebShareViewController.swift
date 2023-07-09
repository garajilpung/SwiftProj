//
//  TwinWebShareViewController.swift
//  SwiftProj
//
//  Created by SMG on 2020/12/14.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import WebKit

@objc(TwinWebShareViewController)
class TwinWebShareViewController: BasicViewController, WKNavigationDelegate, WKUIDelegate  {
    var webView1 : WKWebView!
    var webView2 : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let configuration : WKWebViewConfiguration = WKWebViewConfiguration.init()
        let configuration2 : WKWebViewConfiguration = WKWebViewConfiguration.init()
        
        webView1 = WKWebView.init(frame: CGRect.zero, configuration: configuration)
        webView2 = WKWebView.init(frame: CGRect.zero, configuration: configuration2)
        
        webView1.translatesAutoresizingMaskIntoConstraints = false;
        webView1.uiDelegate = self
        webView1.navigationDelegate = self
        webView2.translatesAutoresizingMaskIntoConstraints = false;
        webView2.uiDelegate = self
        webView2.navigationDelegate = self
                
        self.view .addSubview(webView1)
        self.view .addSubview(webView2)
        
        if #available(iOS 11.0, *)  {
            let safeArea = self.view.safeAreaLayoutGuide;
            
            webView1.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            webView1.bottomAnchor.constraint(equalTo: webView2.topAnchor).isActive = true
            webView1.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            webView1.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            
            webView2.topAnchor.constraint(equalTo: webView1.bottomAnchor).isActive = true
            webView2.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            webView2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            webView2.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            
            webView1.heightAnchor.constraint(equalTo: webView2.heightAnchor).isActive = true
            
            
        }else {
            let lTop = NSLayoutConstraint.init(item: webView1!, attribute: .top , relatedBy: .equal , toItem: self.view.safeAreaLayoutGuide , attribute: .top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: webView1!, attribute: .bottom , relatedBy: .equal, toItem: webView2, attribute: .top , multiplier: 1.0, constant: 0)
            
            let lLeft = NSLayoutConstraint.init(item: webView1!, attribute: .left , relatedBy: .equal , toItem: self.view.safeAreaLayoutGuide , attribute: .left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: webView1!, attribute: .right , relatedBy: .equal , toItem: self.view.safeAreaLayoutGuide , attribute: .right, multiplier: 1.0, constant: 0)
            
            let lHeight = NSLayoutConstraint.init(item: webView1!, attribute: .height , relatedBy: .equal, toItem: webView2, attribute: .height , multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight, lHeight])
            
            let lTop1 = NSLayoutConstraint.init(item: webView2!, attribute: .top , relatedBy: .equal , toItem: webView1 , attribute: .top, multiplier: 1.0, constant: 0)
            
            let lBottom1 = NSLayoutConstraint.init(item: webView2!, attribute: .bottom , relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom , multiplier: 1.0, constant: 0)
            
            let lLeft1 = NSLayoutConstraint.init(item: webView2!, attribute: .left , relatedBy: .equal , toItem: self.view.safeAreaLayoutGuide , attribute: .left, multiplier: 1.0, constant: 0)
            
            let lRight1 = NSLayoutConstraint.init(item: webView2! as Any, attribute: .right , relatedBy: .equal , toItem: self.view.safeAreaLayoutGuide , attribute: .right, multiplier: 1.0, constant: 0)
            
            let lHeight1 = NSLayoutConstraint.init(item: webView2!, attribute: .height , relatedBy: .equal, toItem: webView1, attribute: .height , multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop1, lBottom1, lLeft1, lRight1, lHeight1])
        }
        
        let url = URL.init(string: String.init(format: "%@/php/testPhp.php", Utility.getHost()))
        
        // 쿠키 설정
        if #available(iOS 11.0, *) {
            let cookieStore = webView1.configuration.websiteDataStore.httpCookieStore
            let dispatch_group = DispatchGroup()
            
            if let cookies = GlobalData.sharedInstance.dataCookie {
                for cookie in cookies {
                    dispatch_group.enter()
                    
                    cookieStore.setCookie(cookie) {
                        dispatch_group.leave()
                    }
                }
                
                dispatch_group.notify(queue: .main) {
                    self.webView1.load(URLRequest.init(url: url!))
                }
                
            }else {
                webView1.load(URLRequest.init(url: url!))
            }
            
            
        }else {
            var request = URLRequest.init(url: url!)
            
            if let cookies = GlobalData.sharedInstance.dataCookie {
                let headers = HTTPCookie.requestHeaderFields(with: cookies)
                request.allHTTPHeaderFields = headers
//                [request setValue:[self CookieStringFromCookieDictionary:headers] forHTTPHeaderField:@"Cookie"]; // iOS 10 이하에서 발생하는 문제 수정
                
//                request.httpMethod = "POST"
                webView1.load(request)
            }else {
            
                webView1.load(request)
            }
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
//    - (NSString*)CookieStringFromCookieDictionary:(NSDictionary *)dic {
//        NSMutableString *cookieStr = [NSMutableString string];
//        for (NSString* key in dic.allKeys) {
//            if (cookieStr.length) {
//                [cookieStr appendString:@"; "];
//            }
//            [cookieStr appendFormat:@"%@=%@", key, dic[key]];
//        }
//        return cookieStr.length ? cookieStr : nil;
//    }
    
    // MARK: - WKUIDelegate
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("navigationAction")
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("navigationResponse")
        // 쿠키데이터는 navigationResponse 되는 순간에 넣어진다.
        
        if(webView1 == webView) {
            print("navigationResponse webView1")
            GlobalData.sharedInstance.getCookie(type: 1)
        }else {
            print("navigationResponse webView2")
            GlobalData.sharedInstance.getCookie(type: 1)
        }
        
        
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(webView1 == webView) {
            let url = URL.init(string: String.init(format: "%@/php/testPhp.php", Utility.getHost()))
            webView2.load(URLRequest.init(url: url!))
        }else {
        }
        
        
    }
    
    
//    DispatchQueue.main.async(execute: {
//            self.webView.evaluateJavaScript(js, completionHandler: { (_, error) -> Void in
//                if let error = error {
//                    self.codeGenerationFailed("An error occurred generating code: \(error)")
//                }
//        })
}
