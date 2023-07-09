//
//  ViewController2.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/23.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import WebKit

@objc(ViewController2)
class ViewController2: BasicViewController, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {
    
    var m_WebView : WKWebView = WKWebView.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // userAgent 설정은 웹뷰에서든 userDefault 에서든 먹힌다.
        // 단 아마도 우선순위는 Webview가 먼저고 userDefault 값을 사용하는 것 같다.
        // 만약 웹뷰를 여러개 사용하는데 하나의 URL로 사용하면 공통으로 처리하는 것이 편한 것 같음
        Utility.userAgentInit()
                
        let configuration : WKWebViewConfiguration = WKWebViewConfiguration.init()
        let controller : WKUserContentController = WKUserContentController.init()
        
        controller.add(self, name: "callbackHandler")
        controller.add(self, name: "jsHandler")
        
        configuration.userContentController = controller
        
        m_WebView = WKWebView.init(frame: CGRect.init(), configuration: configuration)
        m_WebView.translatesAutoresizingMaskIntoConstraints = false;
                
        m_WebView.customUserAgent = "webView CustomAgent"
        
        self.view .addSubview(m_WebView)
        
        if #available(iOS 11.0, *)  {
            let safeArea = self.view.safeAreaLayoutGuide;
            
            let top = m_WebView.topAnchor.constraint(equalTo: safeArea.topAnchor)
            top.isActive = true
            
            let bottom = m_WebView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40.0)
            bottom.isActive = true
            
            let left = m_WebView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            left.isActive = true
            
            let right = m_WebView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            right.isActive = true
        }else {
            let lTop = NSLayoutConstraint.init(item: m_WebView, attribute: NSLayoutConstraint.Attribute.top , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: m_WebView, attribute: NSLayoutConstraint.Attribute.bottom , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.bottom , multiplier: 1.0, constant: 40.0)
            
            let lLeft = NSLayoutConstraint.init(item: m_WebView, attribute: NSLayoutConstraint.Attribute.left , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: m_WebView, attribute: NSLayoutConstraint.Attribute.right , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight])
        }
        
        m_WebView.navigationDelegate = self
        m_WebView.uiDelegate = self
                
        let url = URL.init(string: "https://garajilpung.synology.me/test/iOS_KWWebView_Script.html")
//        let url = URL.init(string: "https://garajilpung.synology.me/test/audio.html")
        m_WebView.load(URLRequest.init(url: url!))
        
        
        let imgURL = URL(string: "https://garajilpung.synology.me/test/img/ty2.png")
        
        Utility.loadAsyncImageFromURL(pURL: imgURL!, imageBlock: { (img) in
            print("img size \(img.size.width) \(img.size.height)")
        }) {
            print("이미지가 로드 되지 않았습니다.")
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
    
    // MARK: - WKUIDelegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // windows Open
        return nil;
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        // windows close
        
    }
        
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        //Displays a JavaScript alert panel.
        print("runJavaScriptAlertPanelWithMessage \(message )");
        completionHandler()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        //Displays a JavaScript confirm panel.
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        //Displays a JavaScript text input panel.
    }
   
//    @available(iOS 13, *)
//    func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo) {
//
//    }
//
//    @available(iOS 10.0, *)
//    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
//
//    }
//
//    @available(iOS 13, *)
//    func webView(_ webView: WKWebView, contextMenuConfigurationForElement elementInfo: WKContextMenuElementInfo, completionHandler: @escaping (UIContextMenuConfiguration?) -> Void) {
//
//    }
//
//    @available(iOS 13, *)
//    func webView(_ webView: WKWebView, contextMenuForElement elementInfo: WKContextMenuElementInfo, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating) {
//
//    }
    
    
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("decidePolicyFor navigationAction")
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("decidePolicyFor navigationResponse")
        
        decisionHandler(WKNavigationResponsePolicy.allow);
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // ssl 인증서 체크
        let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)

        completionHandler(URLSession.AuthChallengeDisposition.useCredential, cred)
        
        
//        if challenge.protectionSpace.host.contains("g-y-e-o-m"){
//            let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, urlCredential)
//        }else{
//            completionHandler(.performDefaultHandling, nil)
//        }
        
    }
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let body = message.body as! String
        let name = message.name
        
        let func_param = body.stringToDictionary()!
        
        print("Received event body \(func_param )");
        print("Received event name \(name)");
    }
    
    
//    DispatchQueue.main.async(execute: {
//            self.webView.evaluateJavaScript(js, completionHandler: { (_, error) -> Void in
//                if let error = error {
//                    self.codeGenerationFailed("An error occurred generating code: \(error)")
//                }
//        })
    
    
    @IBAction func onBtn1(_ sender: Any) {
        
        m_WebView.evaluateJavaScript("callWeb1()")
        
    }
    
    @IBAction func onBtn2(_ sender: Any) {
        m_WebView.evaluateJavaScript("callWeb2('name','number')")
    }
    
    @IBAction func onBtn3(_ sender: Any) {
        m_WebView.evaluateJavaScript("callWeb1()")
    }
    
    @IBAction func onBtn4(_ sender: Any) {
        m_WebView.evaluateJavaScript("callWeb1()")
    }
    
    @IBAction func onBtn5(_ sender: Any) {
        m_WebView.evaluateJavaScript("callWeb1()")
    }
}
