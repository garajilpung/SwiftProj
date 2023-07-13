//
//  DatePickerViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/07/01.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(DatePickerViewController)
class DatePickerViewController: BasicViewController {

    var nPy : CGFloat = 0
    
    
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

    override func setView() {
        super.setView()
        
        
    }
    
    
    // MARK: - UIButton Event
    @IBAction func onBtnPckerView(_ sender: Any) {
        
        let dataPicker = DatePickerView.init(frame: CGRect(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth, height: GlobalData.sharedInstance.screenHeight))
        
        dataPicker.clickClose = { dateString in
            DFT_TRACE_PRINT(output: "선택된 날은 \(dateString)")
        }

        dataPicker.onShow()
    }
    
    @IBAction func onBtnPickerVC(_ sender: Any) {
        
        
    }
}
