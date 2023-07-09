//
//  TimeViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/12/20.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit


@objc(TimeViewController)
class TimeViewController: UIViewController {

    @IBOutlet weak var lbTime1: UILabel!
    
    
    public var nTime1 = 0
    public var nTime2 = 0
    
    @IBOutlet weak var lbTimeText1: UILabel!
    @IBOutlet weak var lbTimeText2: UILabel!
    
    @IBOutlet weak var lbTime2Text1: UILabel!
    @IBOutlet weak var lbTime2Text2: UILabel!
    
    @IBOutlet weak var lbTime3Text: UILabel!
    
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

    
    /// 1분은 60 초이다.
    
    @IBAction func onBtn1(_ sender: Any) {
        let date = Date()
        
        print("time 1 \(date.timeIntervalSince1970)")
        print("time 1 \(Int(date.timeIntervalSince1970))")
        
        nTime1 = Int(date.timeIntervalSince1970)
        
        lbTimeText1.text = String(date.timeIntervalSince1970)
        
        let df : DateFormatter! = DateFormatter.init()
        df.dateFormat = "yyyy년MM월dd일 HH시mm분ss초"
        
        lbTimeText2.text = df.string(from: date)
    }
    
    @IBAction func onBtn2(_ sender: Any) {
        let date = Date()
        
        print("time 2 \(date.timeIntervalSince1970)")
        print("time 2 \(Int(date.timeIntervalSince1970))")
        
        nTime2 = Int(date.timeIntervalSince1970)
        
        lbTime2Text1.text = String(date.timeIntervalSince1970)
        let df : DateFormatter! = DateFormatter.init()
        df.dateFormat = "yyyy년MM월dd일 HH시mm분ss초"
        
        lbTime2Text2.text = df.string(from: date)
    }
    
    
    @IBAction func onBtn3(_ sender: Any) {
        lbTime3Text.text = String(nTime2 - nTime1)
    }
}
