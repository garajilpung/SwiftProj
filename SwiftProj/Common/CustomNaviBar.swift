//
//  CustomNaviBar.swift
//  SwiftProj
//
//  Created by SMG on 2022/06/22.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

class CustomNaviBar: UIView {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    
    
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
    private func setInit() -> Void{
        
    }
    
    private func setView() -> Void {
        let  v : UIView = Bundle.main.loadNibNamed("CustomNaviBar", owner: self, options: nil)?[0] as! UIView
        v.frame = self.bounds;
        self.addSubview(v);
    }
    
}
