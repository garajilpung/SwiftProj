//
//  DesignPatternViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/25.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(DesignPatternViewController)
class DesignPatternViewController: BasicViewController {

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

    
    // MARK: - UIButton Event
    @IBAction func onBtnMVC(_ sender: Any) {
        let vc = MVCViewController(nibName: "MVCViewController", bundle: nil)
        
        self.present(vc, animated: true) {
            
        }
    }
    
    @IBAction func onBtnMVP(_ sender: Any) {
        let vc = MVPViewController(nibName: "MVPViewController", bundle: nil)
        
        self.present(vc, animated: true) {
            
        }
    }
    
    @IBAction func onBtnMVVM(_ sender: Any) {
        let vc = MVVMViewController(nibName: "MVVMViewController", bundle: nil)
        
        self.present(vc, animated: true) {
            
        }
    }
}
