//
//  SettingViewController.swift
//  SwiftProj
//
//  Created by SMG on 2020/12/13.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

class SettingViewController: BasicViewController {

    // 서버위치 내뷔 off 외부 on
    @IBOutlet weak var swSP: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userDefaults = UserDefaults.standard
        let arrKeyName = userDefaults.dictionaryRepresentation().keys
        
        if(arrKeyName.contains(SaveKeyName.serverposition.rawValue)) {
            let yn = userDefaults.bool(forKey: SaveKeyName.serverposition.rawValue)
            swSP.setOn(yn, animated: true)
        }else {
            userDefaults.set(false, forKey: SaveKeyName.serverposition.rawValue)
            swSP.setOn(false, animated: true)
        }
        
        
        userDefaults.synchronize()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Button Event
    @IBAction func onBtnClose(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    // MARK: - Switch Event
    @IBAction func onSwitchServerChange(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: SaveKeyName.serverposition.rawValue)
    }
    
    @IBAction func onBtnEtc(_ sender: Any) {
    }
}
