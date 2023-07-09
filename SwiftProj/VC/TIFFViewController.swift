//
//  TIFFViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/06/24.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(TIFFViewController)
class TIFFViewController: BasicViewController {

    @IBOutlet weak var ivImg: UIImageView!
    
    @IBOutlet weak var ivImg2: UIImageView!
    
    @IBOutlet weak var ivIm3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let path = Bundle.main.path(forResource:"tiffExample", ofType:"tiff")
        
//        if(path == nil){
//            print("data [","파일 없음", "]")
//            return
//        }
//
//        let data = NSData.init(contentsOfFile: path!)
//        let img = UIImage(data: data! as Data)
//
        let img = UIImage(contentsOfFile: path!)
        
        ivImg.image = img
        
        
        var arr = Array<UIImage>()
        
        for i in 1...10 {
            let imgName = String(format: "loading_%02d", i)
            let img : UIImage = UIImage.init(named: imgName)!
            
            arr.append(img)
        }
        
        let img2 = UIImage.animatedImage(with: arr, duration: 2)
        ivImg2.image = img2
        
        let data = img2?.pngData()!
        
        let img3 = UIImage(data: data!)
        ivIm3.image = img3
        
//        let img2 = UIImage(named: "tiffEX")
//
//        ivImg2.image = img2
//        DFT_TRACE_PRINT(output: "image Count \(img2?.images?.count)")
        
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
