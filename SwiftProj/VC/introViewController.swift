//
//  introViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/25.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(introViewController)
class introViewController: BasicViewController {

    var mRaonTop :CGFloat = 0
    var mAriTop :CGFloat = 0
    var mAraTop :CGFloat = 0
    
    var mRaonBottom :CGFloat = 0
    var mAriBottom :CGFloat = 0
    var mAraBottom :CGFloat = 0
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    
    @IBOutlet weak var imgRaon1: UIImageView!
    @IBOutlet weak var imgRaon2: UIImageView!
    @IBOutlet weak var imgRaon3: UIImageView!
    
    @IBOutlet weak var imgAri1: UIImageView!
    @IBOutlet weak var imgAri2: UIImageView!
    @IBOutlet weak var imgAri3: UIImageView!
    
    @IBOutlet weak var imgAra1: UIImageView!
    @IBOutlet weak var imgAra2: UIImageView!
    @IBOutlet weak var imgAra3: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lbTitle.isHidden = true;
        lbSubTitle.isHidden = true;
        
        
        imgRaon1.isHidden = true;
        imgRaon2.isHidden = true;
        imgRaon3.isHidden = true;
        
        imgAri1.isHidden = true;
        imgAri2.isHidden = true;
        imgAri3.isHidden = true;
        
        imgAra1.isHidden = true;
        imgAra2.isHidden = true;
        imgAra3.isHidden = true;
        
        animationRaon()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func animationRaon() ->Void {
        mRaonTop = 0;
        imgRaon1.frame = CGRect.init(x: imgRaon1.frame.origin.x, y: imgRaon3.frame.origin.x, width: imgRaon1.frame.size.width, height: imgRaon1.frame.size.height)
        
        imgRaon3.isHidden = false;
        imgRaon1.isHidden = false;
        
        UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseIn, animations: {
            self.imgRaon1.frame = CGRect.init(x: self.imgRaon1.frame.origin.x, y: self.mRaonTop-10, width: self.imgRaon1.frame.size.width, height: self.imgRaon1.frame.size.height)
        }) { (Bool) in
            print("Done!")
            
            UIView.animate(withDuration: 0.18, delay: 0, options: .curveEaseOut, animations: {
                self.imgRaon1.frame = CGRect.init(x: self.imgRaon1.frame.origin.x, y:self.mRaonTop, width: self.imgRaon1.frame.size.width, height:self.imgRaon1.frame.size.height)
                
                let img : UIImage = UIImage.init(named: "ch_raon_sh2")!
                
                self.imgRaon3.frame = CGRect.init(x: self.imgRaon3.frame.origin.x + 12, y: self.imgRaon3.frame.origin.y, width: img.size.width, height: img.size.height)
            }) { (Bool) in
                self.imgRaon3.image = UIImage.init(named: "ch_raon_sh2")
                self.imgRaon2.isHidden = false;
                self.imgRaon2.alpha = 0
             
                UIView.animate(withDuration: 0.08, delay: 0.0, options: .curveEaseOut, animations: {
                    self.imgRaon2.alpha = 1.0
                }) { (Bool) in
                    self.animateAri()
                }
            }
        }
    }
    
    func animateAri() ->Void {
        mAriTop = -4
        let cen :CGPoint = imgAri3.center
        
        imgAri1.frame = CGRect.init(x: imgAri1.frame.origin.x, y: imgAri1.frame.origin.y, width: imgAri1.frame.size.width, height: imgAri1.frame.size.height)
        
        imgAri1.isHidden = false;
        imgAri3.isHidden = false;
        
        UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseIn, animations: {
            self.imgAri1.frame = CGRect.init(x: self.imgAri1.frame.origin.x, y: self.mAriTop-10, width: self.imgAri1.frame.size.width, height: self.imgAri1.frame.size.height)
        }) { (Bool) in
            UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseOut, animations: {
                self.imgAri1.frame = CGRect.init(x: self.imgAri1.frame.origin.x, y: self.mAriTop, width: self.imgAri1.frame.size.width, height: self.imgAri1.frame.size.height)
                
                let img : UIImage = UIImage.init(named: "ch_ari_sh2")!
                self.imgAri3.frame = CGRect.init(x: self.imgAri3.frame.origin.x, y: self.imgAri3.frame.origin.y, width: img.size.width, height: img.size.height)
                self.imgAri3.center = cen;
                
            }) { (Bool) in
                
                self.imgAri3.image = UIImage.init(named: "ch_ari_sh2")!
                self.imgAri2.isHidden = false
                self.imgAri2.alpha = 0
                
                UIView.animate(withDuration: 0.08, delay: 0.0, options: .curveEaseOut, animations: {
                    self.imgAri2.alpha = 1.0
                }) { (Bool) in
                    self.imgAri3.image = UIImage.init(named: "ch_ari_sh3");

                    self.animateAra()
                }
                
            }
        }
    }
    
    func animateAra() ->Void {
        mAraTop = -4
        let cen :CGPoint = imgAra3.center
        
        imgAra1.frame = CGRect.init(x: imgAra1.frame.origin.x, y: imgAra1.frame.origin.y, width: imgAra1.frame.size.width, height: imgAra1.frame.size.height)
        
        imgAra1.isHidden = false;
        imgAra3.isHidden = false;
        
        UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseIn, animations: {
            self.imgAra1.frame = CGRect.init(x: self.imgAra1.frame.origin.x, y: self.mAriTop-10, width: self.imgAra1.frame.size.width, height: self.imgAra1.frame.size.height)
        }) { (Bool) in
            UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseOut, animations: {
                self.imgAra1.frame = CGRect.init(x: self.imgAra1.frame.origin.x, y: self.mAriTop, width: self.imgAra1.frame.size.width, height: self.imgAra1.frame.size.height)
                
                let img : UIImage = UIImage.init(named: "ch_ari_sh2")!
                self.imgAra3.frame = CGRect.init(x: self.imgAra3.frame.origin.x, y: self.imgAra3.frame.origin.y, width: img.size.width, height: img.size.height)
                self.imgAra3.center = cen;
                
            }) { (Bool) in
                
                self.imgAra3.image = UIImage.init(named: "ch_ari_sh2")!
                self.imgAra2.isHidden = false
                self.imgAra2.alpha = 0
                
                UIView.animate(withDuration: 0.08, delay: 0.0, options: .curveEaseOut, animations: {
                    self.imgAra2.alpha = 1.0
                }) { (Bool) in
                    self.imgAra3.image = UIImage.init(named: "ch_ari_sh3");

                    self.animateTitle()
                }
                
            }
        }
    }
    
    func animateTitle()-> Void {
        let top : CGFloat = lbTitle.frame.origin.y;
        
        lbTitle.isHidden = false;
        lbTitle.alpha = 0.0
        lbTitle.frame = CGRect.init(x: lbTitle.frame.origin.x, y: top-20, width: lbTitle.frame.size.width, height:lbTitle.frame.size.height)
        
        UIView.animate(withDuration: 0.26, delay: 0.0, options: .curveEaseOut, animations: {
            self.lbTitle.alpha = 1.0
            self.lbTitle.frame = CGRect.init(x: self.lbTitle.frame.origin.x, y: top, width: self.lbTitle.frame.size.width, height: self.lbTitle.frame.size.height)
        }) { (Bool) in
            self.animateSubTitle()
        }
        
    }
    
    
    
    func animateSubTitle()-> Void {
        let top : CGFloat = lbSubTitle.frame.origin.y;
        
        lbSubTitle.isHidden = false;
        lbSubTitle.alpha = 0.0
        lbSubTitle.frame = CGRect.init(x: lbSubTitle.frame.origin.x, y: top-20, width: lbSubTitle.frame.size.width, height:lbSubTitle.frame.size.height)
        
        UIView.animate(withDuration: 0.26, delay: 0.0, options: .curveEaseOut, animations: {
            self.lbSubTitle.alpha = 1.0
            self.lbSubTitle.frame = CGRect.init(x: self.lbSubTitle.frame.origin.x, y: top, width: self.lbSubTitle.frame.size.width, height: self.lbSubTitle.frame.size.height)
        }) { (Bool) in
            
        }
        
    }
}
