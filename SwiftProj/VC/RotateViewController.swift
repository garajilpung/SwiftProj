//
//  RotateViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/30.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(RotateViewController)
class RotateViewController: BasicViewController {

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

    
    // MARK: - Rotataion Check
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        
        print("RotateViewController");
        print("[", size.width, "] [",size.height, "]");
        
        
        if(size.width > size.height) {
            print("가로")
        }else {
            print("세로")
        }
    }
    
//    // MARK: - ViewController delegate
//      open override var shouldAutorotate: Bool {
//         return false
//     }
//     
//     open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//         return .portrait
//     }
//     
//     open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//         return .portrait
//     }

}
