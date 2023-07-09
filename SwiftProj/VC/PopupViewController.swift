//
//  PopupViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/30.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit


@objc(PopupViewController)
class PopupViewController: BasicViewController {

    var ppMsg : NSMutableAttributedString = NSMutableAttributedString.init(string: "msg Presenting  Hulk Hogan!")
    var ppTitle : NSMutableAttributedString = NSMutableAttributedString.init(string: "알림")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        ppTitle.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25)], range: NSRange.init(location: 0, length: ppTitle.length))
//        ppMsg.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], range: NSRange.init(location: 28, length: 11))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // MARK: - onBtn Method
    @IBAction func onBtn1(_ sender: Any) {
        let alertVC = UIAlertController.init(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alertVC.setValue(ppTitle, forKey: "attributedTitle")
        alertVC.setValue(ppMsg, forKey: "attributedMessage")
        
        let ok1 =  UIAlertAction.init(title: "OK1", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        let ok2 =  UIAlertAction.init(title: "OK2", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        let ok3 =  UIAlertAction.init(title: "OK3", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        alertVC.addAction(ok1)
        alertVC.addAction(ok2)
        alertVC.addAction(ok3)
        
        self.present(alertVC, animated: true) {
            
        }
    
    }
    
    @IBAction func onBtn2(_ sender: Any) {
        let alertVC = UIAlertController.init(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alertVC.setValue(ppTitle, forKey: "attributedTitle")
        alertVC.setValue(ppMsg, forKey: "attributedMessage")
        
        let ok1 =  UIAlertAction.init(title: "OK1", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        let ok2 =  UIAlertAction.init(title: "OK2", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        let ok3 =  UIAlertAction.init(title: "OK3", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        alertVC.addAction(ok1)
        alertVC.addAction(ok2)
        alertVC.addAction(ok3)
        
        self.present(alertVC, animated: true) {
            
        }
    }
    
    @IBAction func onBtn3(_ sender: Any) {
        let alertVC = UIAlertController.init(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alertVC.setValue(ppTitle, forKey: "attributedTitle")
        alertVC.setValue(ppMsg, forKey: "attributedMessage")
        
        let ok1 =  UIAlertAction.init(title: "OK1", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        let ok2 =  UIAlertAction.init(title: "OK2", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        
        alertVC.addAction(ok1)
        alertVC.addAction(ok2)
        
        self.present(alertVC, animated: true) {
            
        }
    }
    
    @IBAction func onBtn4(_ sender: Any) {
        let alertVC = UIAlertController.init(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alertVC.setValue(ppTitle, forKey: "attributedTitle")
        alertVC.setValue(ppMsg, forKey: "attributedMessage")
        
        let ok1 =  UIAlertAction.init(title: "OK1", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        let ok2 =  UIAlertAction.init(title: "OK2", style: .default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        
        alertVC.addAction(ok1)
        alertVC.addAction(ok2)
        
        self.present(alertVC, animated: true) {
            
        }
    }
    
    @IBAction func onBtn5(_ sender: Any) {
        let alertVC = CustomPopup.init()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .coverVertical
        
        
        self.present(alertVC, animated: true) {
            
        }
    }
    
    @IBAction func onBtn6(_ sender: Any) {
        let alertVC = CustomPopup.init()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .coverVertical
        
        guard let keyWindow = UIWindow.key else {
            return
        }
        
        keyWindow.rootViewController!.present(alertVC, animated: true, completion: {
            
        })
    }
    
    @IBAction func onBtn7(_ sender: Any) {
        let alertVC = CustomPopup.init()
        
        alertVC.clickOK = {
            print("popup ok")
        }
        
        alertVC.clickCancel = {
            print("popup cancle")
        }
        
        alertVC.show(true)
    }
    
    
    @IBAction func onBtn8(_ sender: Any) {
        let alertVC = CustomPopup.init()
        
        alertVC.clickN = { buttonIndex in
            if buttonIndex == .ok {
                print("popup ok 1")
            }else if(buttonIndex == .cancle) {
                print("popup cancle 2")
            }
        }
        
        alertVC.show2(true)
    }
    
    @IBAction func onBtn9(_ sender: Any) {
        // Image RootViewController에서 추가함
        // 여기서 로딩바만 호출함
        
        
        
        
        startLoading()
    }

    @IBAction func onBtn10(_ sender: Any) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = "따랑해"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
    
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
            
        }, completion: {(isCompleted) in
            
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func onBtn11(_ sender: Any) {
        let toastLabel = UILabel()
        self.view.addSubview(toastLabel)
        
        let safeArea = self.view.safeAreaLayoutGuide;
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30).isActive = true
        toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toastLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
                
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.red
        toastLabel.textAlignment = .center;
        toastLabel.text = "따랑해"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
            
        }, completion: {(isCompleted) in
            
            toastLabel.removeFromSuperview()
        })
    }
}
