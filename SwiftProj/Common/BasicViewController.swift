//
//  BasicViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/23.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    var m_nMainType : Int = 0
    var m_nSubType : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInit()
        setView()
        setKVO()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addNoti()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeNoti()
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
    func setInit() {
        print("setInit")
    }
    
    func setView() {
        print("setView")
        setLocale()
        
    }
 
    func setLocale() {
        print("setLocale")
    }
    
    func setKVO() {
        print("setKVO")
    }
    
    func addNoti() {
        print("addNoti")
    }
    
    func removeNoti(){
        print("removeNoti")
    }
    
}
