//
//  PDFViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/09.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import PDFKit

// PDFViewController는 사용할 수 없음(전용뷰 화면이 있음)

@objc(PDFAndViewController)
class PDFAndViewController: BasicViewController {
    
    
    @IBOutlet weak var lbWarnning: UILabel!
    
    var vPdf : PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if #available(iOS 11.0, *)  {
            lbWarnning.isHidden = true
            
            vPdf = PDFView.init(frame: CGRect.zero)
            vPdf.displayMode = .singlePage
            vPdf.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(vPdf)
            
            vPdf.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
            vPdf.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 80).isActive = true;
            vPdf.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true;
            vPdf.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true;
            
            let doc = PDFDocument.init(url: URL(string: "https://garajilpung.synology.me/test/zzz.pdf")!)
            vPdf.document = doc
            
        }else {
            lbWarnning.text = "OS iOS11 이상에서만 제공됩니다."
            
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

}
