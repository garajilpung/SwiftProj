//
//  RadiusViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/04/20.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit


@objc(RadiusViewController)
class RadiusViewController: BasicViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        v1.layer.cornerRadius = 20
        v1.layer.borderWidth = 3
        
        
        let path = UIBezierPath.init(roundedRect: v2.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = v2.bounds
        maskLayer.path = path.cgPath
        v2.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = 6
        borderLayer.frame = v2.bounds
        v2.layer.addSublayer(borderLayer)
        
        
        //iOS 11.0 이후에만 가능
        v3.layer.cornerRadius = 20
        v3.layer.borderWidth = 3
        v3.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
