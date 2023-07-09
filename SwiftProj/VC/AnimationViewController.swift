//
//  AnimationViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/01/21.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

@objc(AnimationViewController)
class AnimationViewController: UIViewController {

    var pY1 : CGFloat!
    var pY2 : CGFloat!
    
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lc_lb2Y: NSLayoutConstraint!
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        pY1 = lb1.frame.origin.y
        pY2 = lc_lb2Y.constant
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pY1 = lb2.frame.origin.y
    }
    
    
    
    
    // MARK: - Button Method
    
    @IBAction func onBtn_FReset(_ sender: Any) {
        let frame = lb1.frame
        
        lb1.frame = CGRect(x: frame.origin.x, y: pY1, width: frame.size.width, height: frame.size.height)
    }
    
    @IBAction func onBtn_CReset(_ sender: Any) {
        lc_lb2Y.constant = pY2
        self.view.layoutIfNeeded();
    }
    
    @IBAction func onBtn_FAni(_ sender: Any) {
        UIView.animate(withDuration: 2) {
            let frame = self.lb1.frame
            self.lb1.frame = CGRect(x: frame.origin.x, y: self.pY1+200, width: frame.size.width, height: frame.size.height)
        };
    }
    
    @IBAction func onBtn_CAni(_ sender: Any) {
        UIView.animate(withDuration: 2) {
            self.lc_lb2Y.constant = self.pY2 + 200
            self.view.layoutIfNeeded();
        };
    }
}
