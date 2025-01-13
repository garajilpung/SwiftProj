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
            
//            let data =
            
            let request = NSMutableURLRequest(url: URL(string: "https://garajilpung.synology.me/test/zzz.pdf")!)
            
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let dTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if(error != nil) {
                    
                }else {
                    if(data != nil) {
                        var str2 = data!.base64EncodedString();
                        var str = data!.base64EncodedString(options: .endLineWithCarriageReturn);
                        print("str length \(str.count)")
                        print("str2 length \(str2.count)")
                        
                        let vv = str.data(using: .utf8)!
                        
                        print("str to data length \(vv.count)");
//                        print("str [\(str)]");
                        
//                        str = str.replacingOccurrences(of: "/n", with: "");
//                        str = str.replacingOccurrences(of: "/", with: "");
                        
                        print("str to 32 length \(str.count)");
                        var vv2 = Data(base64Encoded: str.data(using: .utf8)!)
                        print("vv2 to 32 length \(vv2?.count)");
                        
                        DispatchQueue.main.async { [weak self] in
                            let doc = PDFDocument.init(data: vv2!)
                            self?.vPdf.document = doc
                        }
//                        print("str [\(str)]");
                    }else {
                        
                    }
                }
            }
            
            dTask.resume()
            
            
//            vPdf.document = doc
            
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
