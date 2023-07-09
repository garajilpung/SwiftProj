//
//  ThreeView.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/26.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

class ThreeView: UIView {

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
    func setInit()-> Void{
    }
    
    func setView()->Void {
        let  v : UIView = Bundle.main.loadNibNamed("ThreeView", owner: self, options: nil)?[0] as! UIView
        v.frame = self.bounds;
        self.addSubview(v);
    }

}
