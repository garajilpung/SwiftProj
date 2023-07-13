//
//  DatePickerView.swift
//  SwiftProj
//
//  Created by SMG on 2022/07/01.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    @IBOutlet weak var vDatePicker: UIDatePicker!
    
    public var clickClose : ((String)->Void)? = nil
    
    required init() {
        super.init(frame: CGRect.zero)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        setInit()
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setInit()
        setView()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - User method
    func setInit()-> Void {
        
    }
    
    func setView()-> Void {
        let  v : UIView = Bundle.main.loadNibNamed("DatePickerView", owner: self, options: nil)?[0] as! UIView
        v.frame = self.bounds;
        self.addSubview(v);
        
        // 강제로 위치를 이동시킨다.
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
        
        if #available(iOS 14.0, *) {
            vDatePicker.preferredDatePickerStyle = .inline
        }else if #available(iOS 13.4, *) {
            vDatePicker.preferredDatePickerStyle = .wheels
        }else {
            
        }
    }
    
    
    func onShow() {
        
        UIWindow.key?.addSubview(self)
        
        UIView.animate(withDuration: 1) {
            
            self.frame = CGRect(x: self.frame.origin.x, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    
    // MARK: - Button Event
    @IBAction func onBtnClose(_ sender: Any) {
        
        if let clickClose = clickClose {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            
            let date : String = dateFormatter.string(from: vDatePicker.date)
            
            clickClose(date)
        }
        
        
        UIView.animate(withDuration: 1) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
            self.removeFromSuperview()
        }
        
    }
}
