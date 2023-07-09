//
//  WebScriptMHandler.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/30.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import WebKit


class WebScriptMHandler : NSObject {

    
    
}

extension WebScriptMHandler: WKScriptMessageHandler{
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("MHandler \(message.body)")
    }
}
