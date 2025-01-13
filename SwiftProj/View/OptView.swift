//
//  OptView.swift
//  SwiftProj
//
//  Created by SMG on 6/24/24.
//  Copyright © 2024 garajilpung. All rights reserved.
//

import UIKit

class OptView: UIView {

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
        let  v : UIView = Bundle.main.loadNibNamed("OptView", owner: self, options: nil)?[0] as! UIView
        v.frame = self.bounds;
        self.addSubview(v);
    }
    
}
