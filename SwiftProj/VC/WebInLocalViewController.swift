//
//  WebInLocalViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/07/13.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import WebKit
import UniformTypeIdentifiers

/*
 일반적으로 웹에서 로컬 데이터로 접근하는 것을 불가능하다.
 (익스플로어는 가능하나 여타 브라우저는 불가능하다.)
 
 로컬 데이터를 가져다 쓸 수 있는 방법은 서버 설정을 바꾸어서 로컬 주소를 등록하면 가능하나. 서버 설정을 건드려야 해서 이건 사용 불가
 다른 방법으로 아래의 방법이 있다.
 커스텀 스키마를 등록하고 그것을 호출하면 관련 데이터를 웹쪽으로 던지는 것이다.
 */

class MySchemeHandler: NSObject, WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        guard let url = urlSchemeTask.request.url,
              let fileUrl = fileUrlFromUrl(url),
              let mimeType = mimeType(ofFileAtUrl: fileUrl),
              let data = try? Data(contentsOf: fileUrl) else { return }

        let response = URLResponse(url: url,
                                   mimeType: mimeType,
                                   expectedContentLength: data.count,
                                   textEncodingName: nil)
        
        
        
        urlSchemeTask.didReceive(response)
        urlSchemeTask.didReceive(data)
        urlSchemeTask.didFinish()
        
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        
    }
    
    private func fileUrlFromUrl(_ url: URL) -> URL? {
        guard let assetName = url.host else { return nil }
        return Bundle.main.url(forResource: assetName,
                               withExtension: "",
                               subdirectory: "")
    }

    private func mimeType(ofFileAtUrl url: URL) -> String? {
        if #available(iOS 14.0, *) {
            guard let type = UTType(filenameExtension: url.pathExtension) else {
                return nil
            }
            
            return type.preferredMIMEType
        } else {
            // Fallback on earlier versions
            
            switch url.pathExtension {
            case "png":
                return "image/png"
            case "gif":
                return "image/gif"
            default:
                return ""
            }
        }
        
    }
}

@objc(WebInLocalViewController)
class WebInLocalViewController: BasicViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    
    let preferences = WKPreferences()
    private var mWebView : WKWebView = WKWebView.init()
    
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

    override func setView() {
        super.setView()
        
        let configuration : WKWebViewConfiguration = WKWebViewConfiguration.init()
        let controller : WKUserContentController = WKUserContentController.init()
        
//        controller.add(mHandler, name: "mHandler")
//        controller.add(self, name: "jsHandler")

        configuration.userContentController = controller
        
        configuration.preferences = preferences
        configuration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        configuration.setURLSchemeHandler(MySchemeHandler(), forURLScheme: "localstorage")
        
        mWebView = WKWebView.init(frame: CGRect.init(), configuration: configuration)
        mWebView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view .addSubview(mWebView)
        
        mWebView.navigationDelegate = self
        
        if #available(iOS 11.0, *)  {
            let safeArea = self.view.safeAreaLayoutGuide;
            
            let top = mWebView.topAnchor.constraint(equalTo: safeArea.topAnchor)
            top.isActive = true
            
            let bottom = mWebView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            bottom.isActive = true
            
            let left = mWebView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            left.isActive = true
            
            let right = mWebView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            right.isActive = true
        }else {
            let lTop = NSLayoutConstraint.init(item: mWebView, attribute: NSLayoutConstraint.Attribute.top , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: mWebView, attribute: NSLayoutConstraint.Attribute.bottom , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.bottom , multiplier: 1.0, constant: 0)
            
            let lLeft = NSLayoutConstraint.init(item: mWebView, attribute: NSLayoutConstraint.Attribute.left , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: mWebView, attribute: NSLayoutConstraint.Attribute.right , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight])
        }
        
        
        mWebView.load(URLRequest(url: URL(string:"https://garajilpung.synology.me/test/webinlocal.html")!))
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
