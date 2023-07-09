//
//  SingleViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/25.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(SingleViewController)
class SingleViewController: BasicViewController {

    var m_ViewContent : UIView = UIView.init()
    var safeArea : UILayoutGuide = UILayoutGuide.init()
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnOK2: UIButton!
    @IBOutlet weak var btnOK3: UIButton!
    @IBOutlet weak var btnOK4: UIButton!
    @IBOutlet weak var btnOK5: UIButton!
    
    
    /*
     xib를 통해 뷰를 로드하는 경우
     아래 초기화 함수가 필요하다. 때에 따라
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
     
     이 함수도 사용할 수 있다(따로 선언하지 않아도 된다. ). 순서상 위 init 함수가 먼저 호출된다.
     override func awakeFromNib() {
         super.awakeFromNib()
     }
     
     구조상 하나의 xib에 여러개의 뷰를 추가할 수 있지만 공통적인 화면이 아니라면 하나에 한개의 뷰만을 사용하도록 하자.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_ViewContent = Bundle.main.loadNibNamed("DummyView", owner: self, options:nil)?[0] as! OneView
        m_ViewContent.backgroundColor = UIColor.red
        m_ViewContent.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(m_ViewContent)
        
        if #available(iOS 11.0, *)  {
            safeArea = self.view.safeAreaLayoutGuide;
            
            let top = m_ViewContent.topAnchor.constraint(equalTo: safeArea.topAnchor)
            top.isActive = true
            
            let bottom = m_ViewContent.bottomAnchor.constraint(equalTo: btnOK.topAnchor)
            bottom.isActive = true
            
            let left = m_ViewContent.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            left.isActive = true
            
            let right = m_ViewContent.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            right.isActive = true
            
            self.view.addConstraints([top, bottom, left, right])
        }else {
            
            let lTop = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.top , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.bottom , relatedBy:NSLayoutConstraint.Relation.equal , toItem: btnOK , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lLeft = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.left , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.right , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight])
        }
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - onBtn Event
    
    
    @IBAction func onBtn1(_ sender: Any) {
        m_ViewContent.removeFromSuperview()
        
        m_ViewContent = Bundle.main.loadNibNamed("DummyView", owner: self, options:nil)?[0] as! OneView
        m_ViewContent.backgroundColor = UIColor.red
        m_ViewContent.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(m_ViewContent)
        
        if #available(iOS 11.0, *)  {
            safeArea = self.view.safeAreaLayoutGuide;
            
            let top = m_ViewContent.topAnchor.constraint(equalTo: safeArea.topAnchor)
            top.isActive = true
            
            let bottom = m_ViewContent.bottomAnchor.constraint(equalTo: btnOK.topAnchor)
            bottom.isActive = true
            
            let left = m_ViewContent.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            left.isActive = true
            
            let right = m_ViewContent.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            right.isActive = true
            
            self.view.addConstraints([top, bottom, left, right])
        }else {
            
            let lTop = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.top , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.bottom , relatedBy:NSLayoutConstraint.Relation.equal , toItem: btnOK , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lLeft = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.left , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.right , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight])
        }
        
    }
 
    @IBAction func onBtn2(_ sender: Any) {
        m_ViewContent.removeFromSuperview()
        
        m_ViewContent = Bundle.main.loadNibNamed("DummyView", owner: self, options:nil)?[1] as! TwoView
        m_ViewContent.backgroundColor = UIColor.magenta
        m_ViewContent.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(m_ViewContent)
        
        if #available(iOS 11.0, *)  {
            safeArea = self.view.safeAreaLayoutGuide;
            
            let top = m_ViewContent.topAnchor.constraint(equalTo: safeArea.topAnchor)
            top.isActive = true
            
            let bottom = m_ViewContent.bottomAnchor.constraint(equalTo: btnOK.topAnchor)
            bottom.isActive = true
            
            let left = m_ViewContent.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            left.isActive = true
            
            let right = m_ViewContent.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            right.isActive = true
            
            self.view.addConstraints([top, bottom, left, right])
        }else {
            
            let lTop = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.top , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.bottom , relatedBy:NSLayoutConstraint.Relation.equal , toItem: btnOK , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lLeft = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.left , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.right , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight])
        }
    }
    
    @IBAction func onBtn3(_ sender: Any) {
        m_ViewContent.removeFromSuperview()
        m_ViewContent = ThreeView.init()
        m_ViewContent.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(m_ViewContent)
        
        if #available(iOS 11.0, *)  {
            safeArea = self.view.safeAreaLayoutGuide;
            
            let top = m_ViewContent.topAnchor.constraint(equalTo: safeArea.topAnchor)
            top.isActive = true
            
            let bottom = m_ViewContent.bottomAnchor.constraint(equalTo: btnOK.topAnchor)
            bottom.isActive = true
            
            let left = m_ViewContent.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            left.isActive = true
            
            let right = m_ViewContent.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            right.isActive = true
            
            self.view.addConstraints([top, bottom, left, right])
        }else {
            
            let lTop = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.top , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lBottom = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.bottom , relatedBy:NSLayoutConstraint.Relation.equal , toItem: btnOK , attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let lLeft = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.left , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
            
            let lRight = NSLayoutConstraint.init(item: m_ViewContent, attribute: NSLayoutConstraint.Attribute.right , relatedBy:NSLayoutConstraint.Relation.equal , toItem: self.view.safeAreaLayoutGuide , attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
            
            self.view.addConstraints([lTop, lBottom, lLeft, lRight])
        }
    }
    
    @IBAction func onBtn4(_ sender: Any) {
        m_ViewContent.removeFromSuperview()
    }
    
    @IBAction func onBtn5(_ sender: Any) {
        m_ViewContent.removeFromSuperview()
        
    }
}
