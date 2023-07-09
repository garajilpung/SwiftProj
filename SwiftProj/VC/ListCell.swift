//
//  ListCell.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/27.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var lbText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class ListCell2: UITableViewCell {
    
    var lbText : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default , reuseIdentifier: "tableViewCell2")
        
        lbText = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth, height: 20))
        
        self.addSubview(lbText)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
