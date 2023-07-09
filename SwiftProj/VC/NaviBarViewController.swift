//
//  NaviBarViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/30.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(NaviBarViewController)
class NaviBarViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let p : UILabel = UILabel.init(frame:CGRect.init())
        p.text = "amddmvowm"
        p.backgroundColor = UIColor.red
        p.font = UIFont.systemFont(ofSize: 24.0)
        p.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(p)
        
        if #available(iOS 11.0, *)  {
            let safeArea = self.view.safeAreaLayoutGuide;
            
            let top = p.topAnchor.constraint(equalTo: safeArea.topAnchor)
            top.isActive = true
            
//            let bottom = p.heightAnchor.constraint(equalToConstant: 44)
//            bottom.isActive = true
            
            let bottom = p.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            bottom.isActive = true
            
            let left = p.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            left.isActive = true
            
            let right = p.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            right.isActive = true
            
            self.view.addConstraints([top, bottom, left, right])
        }else {
            let lTop = NSLayoutConstraint.init(item: p, attribute: NSLayoutConstraint.Attribute.top , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: p, attribute: NSLayoutConstraint.Attribute.height , relatedBy:NSLayoutConstraint.Relation.equal , toItem: nil , attribute: NSLayoutConstraint.Attribute.bottom , multiplier: 1.0, constant: 44)
            
            let lLeft = NSLayoutConstraint.init(item: p, attribute: NSLayoutConstraint.Attribute.left , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: p, attribute: NSLayoutConstraint.Attribute.right , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight])
        }
        
        
        
        let lotoolbar = UIToolbar.init(frame: CGRect.init(x:0, y:64, width: GlobalData.sharedInstance.screenWidth, height:44))
        lotoolbar.tintColor = UIColor.black
        
        let button1 = UIBarButtonItem.init(title: "Date", style: UIBarButtonItem.Style.done, target: self, action: #selector(dateToolbardoneButtonAction))
        let button2 = UIBarButtonItem.init(title: "Time", style: UIBarButtonItem.Style.done, target: self, action: #selector(timeToolbarbuttonAction))
    
//        self.navigationController?.navigationItem.leftBarButtonItem = button1
//        self.navigationController?.navigationItem.rightBarButtonItem = button2

        self.navigationItem.leftBarButtonItem = button1
        self.navigationItem.rightBarButtonItem = button2
        
//        lotoolbar.items = [button1, button2]
    
//        self.view.addSubview(lotoolbar)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let bar = self.navigationController?.navigationBar
        
        bar?.barStyle = UIBarStyle.black
        bar?.tintColor = UIColor.yellow
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - User Method
    @objc func dateToolbardoneButtonAction(sender: UIBarButtonItem) -> Void {
        
    }
    
    @objc func timeToolbarbuttonAction(sender: UIBarButtonItem) -> Void{
        
    }
}
