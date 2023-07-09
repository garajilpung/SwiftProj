//
//  ImageEditViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/02.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(ImageEditViewController)
class ImageEditViewController: BasicViewController {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 구현하려고 했으나 적당한 이미지를 구할 수가 없으서 못함
        // 그리고 에셋 파일 자체에서 이미지의 세부 이미지를 선택하면 스트레치를 할수 있게 값을 입력할 수 있다.
//        let image = UIImage.init(named: "vv")
//        image = image?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20), resizingMode: UIImage.ResizingMode.stretch)
//
//        image = image?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20), resizingMode: UIImage.ResizingMode.tile)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func onBtnEvent(_ sender: UIButton) {
        let tag : Int = sender.tag
        
        
        switch tag {
        case 100:
            imgView.contentMode = .topLeft
        case 101:
            imgView.contentMode = .top
        case 102:
            imgView.contentMode = .topRight
        case 103:
            imgView.contentMode = .left
        case 104:
            imgView.contentMode = .center
        case 105:
            imgView.contentMode = .right
        case 106:
            imgView.contentMode = .bottomLeft
        case 107:
            imgView.contentMode = .bottom
        case 108:
            imgView.contentMode = .bottomRight
            
        case 110:
            imgView.contentMode = .scaleToFill
        case 111:
            imgView.contentMode = .scaleAspectFit
        case 112:
            imgView.contentMode = .scaleAspectFill
        default:
            imgView.contentMode = .center
        }
    }
    
    
}
