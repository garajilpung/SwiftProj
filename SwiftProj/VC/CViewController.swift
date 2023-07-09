//
//  CViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/06/22.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(CViewController)
class CViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Basic UserMethod
    override func setInit() {
        super.setInit()
    }
    
    override func setView() {
        super.setView()
        
    }
 
    override func addNoti() {
        super.addNoti()
    }
    
    override func removeNoti() {
        super.removeNoti()
    }
}
