//
//  LocalWebViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/07.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import WebKit

@objc(LocalWebViewController)
class LocalWebViewController: BasicViewController {
    
    

    var mWebView : WKWebView = WKWebView.init()
    var mHandler : WebScriptMHandler = WebScriptMHandler.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let configuration : WKWebViewConfiguration = WKWebViewConfiguration.init()
        let controller : WKUserContentController = WKUserContentController.init()
        
        controller.add(mHandler, name: "mHandler")
        controller.add(self, name: "jsHandler")
        
        configuration.userContentController = controller
        
        mWebView = WKWebView.init(frame: CGRect.init(), configuration: configuration)
        mWebView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view .addSubview(mWebView)
        
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
        
        mWebView.navigationDelegate = self
        mWebView.uiDelegate = self
        
        loadHtml()
        
//        saveFile()
//        loadDocFile()
    }


    func loadHtml() {
        if let url = Bundle.main.url(forResource: "main", withExtension: "html")
        {
            do
            {
                let contents = try String(contentsOfFile: url.path)
                print("URL \(url.deletingLastPathComponent())")
                mWebView.loadHTMLString(contents, baseURL: url.deletingLastPathComponent())
            }
            catch
            {
                print("Could not load the HTML string.")
            }
        }
    }
    
    func saveFile(){
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let savaMainHtml = documentURL.appendingPathComponent("main.html")
        
        let saveImgDir = documentURL.appendingPathComponent("webImg")
        let savaImg1 = documentURL.appendingPathComponent("webImg/banner_01.png")
        let savaImg2 = documentURL.appendingPathComponent("webImg/banner_02.png")
        let savaImg3 = documentURL.appendingPathComponent("webImg/banner_03.png")
        
        print("documentURL \(documentURL)")
        print("savaMainHtml \(savaMainHtml)")
        
        if let url = Bundle.main.url(forResource: "main", withExtension: "html") {
            do {
                let contents = try Data(contentsOf: url)
                try contents.write(to: savaMainHtml)
            }catch {
                print(error.localizedDescription)
            }
        }
        
        do {
            try FileManager.default.createDirectory(atPath: saveImgDir.path, withIntermediateDirectories: false, attributes: nil)
            print("폴더 생성")
        }catch {
            print("폴더 생성 안됨.")
        }
        
        if let url = Bundle.main.url(forResource: "banner_01", withExtension: "png", subdirectory: "/webImg") {
            do {
                let contents = try Data(contentsOf: url)
                try contents.write(to: savaImg1)
            }catch {
                print(error.localizedDescription)
            }
        }
        
        if let url = Bundle.main.url(forResource: "banner_02", withExtension: "png", subdirectory: "/webImg") {
            do {
                let contents = try Data(contentsOf: url)
                try contents.write(to: savaImg2)
            }catch {
                print(error.localizedDescription)
            }
        }
        
        if let url = Bundle.main.url(forResource: "banner_03", withExtension: "png", subdirectory: "/webImg") {
            do {
                let contents = try Data(contentsOf: url)
                try contents.write(to: savaImg3)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadDocFile() {
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        mWebView.loadFileURL(documentURL.appendingPathComponent("main.html"), allowingReadAccessTo: documentURL)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extension : WKScriptMessageHandler
extension LocalWebViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("JSHandler \(message.body)")
        
        var jsonString : String = message.body as! String
        var jsonDic = jsonString.stringToDictionary()
        
        guard let jsonDic = jsonDic else {
            return
        }
        
        /*
         json 구조
         cmdName : String
         cmdParam : Array
         callBackName : String
         callBackParamCount : Int or String
         */
        
    }
    
    
}


// MARK: - Extension : WKNavigationDelegate
extension LocalWebViewController : WKNavigationDelegate {
    
}


// MARK: - Extension : WKUIDelegate
extension LocalWebViewController : WKUIDelegate {
    
}
