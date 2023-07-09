//
//  LangViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/20.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(LangViewController)
class LangViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var tv: UITextView!
    
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

    
    // MARK: - Custom Func
    func updateLang() {
        btn.setTitle("btn-Title".localizeString(), for: .normal)
        lb.text = "lb-Title".localizeString()
        tf.text = "tf-Title".localizeString()
        tv.text = "tv-Title".localizeString()
    }
    
    // MARK: - Segment Event
    @IBAction func onSegment(_ sender: UISegmentedControl) {
        let tag = sender.selectedSegmentIndex
        let userDefault = UserDefaults.standard
        
        if(tag == 0) {
            userDefault.set("ko", forKey: "lang")
        }else if(tag == 1) {
            userDefault.set("en", forKey: "lang")
        }
        
        userDefault.synchronize()
        
        updateLang()
    }
    
}
