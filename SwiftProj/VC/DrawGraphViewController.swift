//
//  DrawGraphViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/01/25.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

class DrawView : UIView {
    
    public var nValue:CGFloat!
    
    override func draw(_ rect: CGRect) {
        drawArc(cPoint: CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height/2), cRadius: (self.bounds.size.height - nValue*2)/2, fillColor: UIColor.blue.cgColor, startDegree: 270, endDegree: 30)
        
        drawArc(cPoint: CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height/2), cRadius: (self.bounds.size.height - nValue*2)/2, fillColor: UIColor.red.cgColor, startDegree: 30, endDegree: 120)
        
        drawArc(cPoint: CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height/2), cRadius: (self.bounds.size.height - nValue*2)/2, fillColor: UIColor.yellow.cgColor, startDegree: 120, endDegree: 250)
        
        drawCircle(rect : CGRect(x: 30, y: 30, width: self.bounds.size.width - 30*2, height: self.bounds.size.height - 30*2))
    }
    
    func drawCircle(rect:CGRect){
        let context:CGContext! = UIGraphicsGetCurrentContext()
        context.setLineWidth(0)
        context.move(to: CGPoint(x:rect.origin.x , y:rect.origin.y))
        context.addEllipse(in: rect)
        context.setFillColor(UIColor.white.cgColor)
        context.fillPath()
    }
    
    func drawArc(cPoint:CGPoint, cRadius:CGFloat, fillColor:CGColor, startDegree:CGFloat, endDegree:CGFloat) {
        let context:CGContext! = UIGraphicsGetCurrentContext()
        context.setLineWidth(2)
        context.move(to: cPoint)
        context.addArc(center: cPoint, radius: cRadius, startAngle: radians(degrees: startDegree), endAngle: radians(degrees: endDegree), clockwise: false);
        context.setFillColor(fillColor)
        context.fillPath()
    }
    
    
    func radians(degrees: CGFloat) -> CGFloat {
        return CGFloat(degrees * CGFloat.pi / 180)
    }
}



@objc(DrawGraphViewController)
class DrawGraphViewController: BasicViewController {

    @IBOutlet weak var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawView.nValue = 10
        
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
    
    
}
