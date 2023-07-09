//
//  CaptureViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/24.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(CaptureViewController)
class CaptureViewController: BasicViewController {

    @IBOutlet weak var m_View: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let center = NotificationCenter.default
//        center.addObserver(self,
//                           selector: #selector(funcCapture(_:)),
//                           name: NSNotification.Name("kScreenRecordingDetectorRecordingStatusChangedNotification"),
//                           object: nil)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("kScreenRecordingDetectorRecordingStatusChangedNotification"), object: nil, queue: OperationQueue.main) { (Notification) in
            
            print("Captuer Noti")
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

    // MARK: - User Method
    func screenCapture(view:UIView) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    @objc func funcCapture(_ notification: Notification) -> Void {
        print("Captuer Noti")
        
    }
    
    // MARK: - Button Event
    @IBAction func onBtnCapture(_ sender: Any) {
        
        let img = screenCapture(view: self.view)
        
        m_View.image = img
    }
    
}
