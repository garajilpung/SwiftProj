//
//  CustomPopup.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/04.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

enum CustomPopupButtonIndex : Int {
    case ok
    case cancle
    case other
}

class CustomPopup: UIViewController {
    public var clickOK : (()->Void)? = nil
    public var clickCancel : (()->Void)? = nil
    
    public var clickN : ((CustomPopupButtonIndex)->Void)? = nil

    public var strTitle : String = "알림"
    public var strMsg : String = "자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다. 자세한 설명 내용입니다."
        

    //
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lcContentSizeHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tvContent.text = strMsg
        tvContent.textContainer.lineBreakMode = .byCharWrapping
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tvContent.contentSize.height > 200 {
            
            if GlobalData.sharedInstance.screenHeight - 188 < tvContent.contentSize.height {
                lcContentSizeHeight.constant = GlobalData.sharedInstance.screenHeight - 188
            }else {
                lcContentSizeHeight.constant = tvContent.contentSize.height
            }
            
        }else { // 아무처리도 하지 않는다. 최소 사이즈를 지킨다.
            
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

    @IBAction func onBtnOk(_ sender: Any) {
        if let callback = self.clickOK {
            callback()
        }
        
        if let callback2 = self.clickN {
            callback2(.ok)
        }
        
        self.dismiss(animated: true) {
            
        }
    }
    
    
    @IBAction func onBtnCancle(_ sender: Any) {
        if let callback = self.clickCancel {
            callback()
        }
        
        if let callback2 = self.clickN {
            callback2(.cancle)
        }
        
        self.dismiss(animated: true) {
            
        }
    }
    
    
    public func show(_ animated: Bool) {
        guard let keyWindow = UIWindow.key else {
            return
        }
        
        self.modalPresentationStyle = .overFullScreen
        
        keyWindow.rootViewController!.present(self, animated: animated, completion: {
            
        })
    }
    
    public func show2(_ animated: Bool) {
        guard let keyWindow = UIWindow.key else {
            return
        }
        
        self.modalPresentationStyle = .overFullScreen
        
        keyWindow.rootViewController!.present(self, animated: animated, completion: {
            
        })
    }
}
