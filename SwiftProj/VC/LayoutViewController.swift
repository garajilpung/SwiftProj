//
//  LayoutViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/09.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(LayoutViewController)
class LayoutViewController: BasicViewController {

    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var p : [UILabel] = []
        // Do any additional setup after loading the view.
        
        for _ in 0 ... 8 {
            let temp = UILabel.init(frame: CGRect.zero)
            temp.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(temp)
            
            temp.widthAnchor.constraint(equalToConstant: 80).isActive = true
            temp.heightAnchor.constraint(equalToConstant: 80).isActive = true
            temp.text = "Layout 처리"
            
            p.append(temp)
        }
        
        p[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        p[0].leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true;
        
        p[1].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        p[1].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        
        p[2].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        p[2].rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true;
        
        p[3].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true;
        p[3].leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true;
        
        p[4].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true;
        p[4].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        
        p[5].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true;
        p[5].rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true;
        
        p[6].bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
        p[6].leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true;
        
        p[7].bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
        p[7].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        
        p[8].bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
        p[8].rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true;

        btn.setTitleColor(UIColor.red, for: UIControl.State.selected)
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
