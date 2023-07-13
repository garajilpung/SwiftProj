//
//  ExcelViewerViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/07/13.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import WebKit

@objc(ExcelViewerViewController)
class ExcelViewerViewController: BasicViewController {

    private var mWebView : WKWebView = WKWebView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let configuration : WKWebViewConfiguration = WKWebViewConfiguration.init()
        let controller : WKUserContentController = WKUserContentController.init()
        
//        controller.add(mHandler, name: "mHandler")
//        controller.add(self, name: "jsHandler")
//
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
        
//        mWebView.navigationDelegate = self
//        mWebView.uiDelegate = self
        
//        mWebView.load(URLRequest(url: URL(string:"https://garajilpung.synology.me/test/excelView.xlsx")!))
        
        if let url = Bundle.main.url(forResource: "excelView", withExtension: "xlsx")
        {
            do
            {
//                let contents = try String(contentsOfFile: url.path)
                print("URL \(url.deletingLastPathComponent())")
//                mWebView.loadHTMLString(contents, baseURL: url.deletingLastPathComponent())
//                mWebView.loadFileURL(url, allowingReadAccessTo: url)
//                mWebView.load(URLRequest()
                mWebView.load(URLRequest(url: url))
                
                let data = try Data.init(contentsOf: url)
                
//                mWebView.loadDataContent(data: data, mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
//                mWebView.load(data, mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", characterEncodingName: "", baseURL: url.deletingLastPathComponent())
            }
            catch
            {
                print("Could not load the HTML string.")
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
    
   

}
