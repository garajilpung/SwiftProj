//
//  ShakeViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/19.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(ShakeViewController)
class ShakeViewController: UIViewController {

    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lb1.text = "모션 준비중"
        lb1.text = "모션 준비중"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Shake Event
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("모션 시작")
        if motion == .motionShake {
            lb1.text = "흔들기 모션 중"
            lb2.text = "흔들기 모션 시작됨"
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        lb1.text = "흔들기 모션 종료"
        print("모션 종료")
        if motion == .motionShake {
            print("흔들기 종료")
        }
    }
    
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        lb1.text = "흔들기 모션 취소"
        print("모션 취소")
        if motion == .motionShake {
            print("흔들기 취소")
        }
    }

}
