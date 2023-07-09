//
//  DocViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/03/03.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

@objc(DocViewController)
class DocViewController: BasicViewController, UIDocumentPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // info.plist 파일에 아래를 추가한다.
    // Application supports iTunes file sharing : true
    // Supports opening documents in place : true
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onBtnDocVC(_ sender: UIButton) {
        let tag = sender.tag
        var docVC : UIDocumentPickerViewController? = nil
        
        
        
        switch tag {
        case 100:
            docVC = UIDocumentPickerViewController.init(documentTypes: ["public.data"], in: UIDocumentPickerMode.import)
            docVC?.delegate = self
            self.present(docVC!, animated: true) {
                
            }
        case 101:
            docVC = UIDocumentPickerViewController.init(documentTypes: ["public.data"], in: UIDocumentPickerMode.open)
            docVC?.delegate = self
            self.present(docVC!, animated: true) {
                
            }
        case 102:
            showAlert("exportToService는 사용할 수 없음");
        case 103:
            showAlert("moveToService는 사용할 수 없음");
        default:
            docVC = UIDocumentPickerViewController.init(documentTypes: ["public.data"], in: UIDocumentPickerMode.import)
            docVC?.delegate = self
            self.present(docVC!, animated: true) {
                
            }
        }
        
        
        
    }
    
    
    
    // MARK:  User Method
    func showAlert(_ msg: String) {
        let alertVC = UIAlertController.init(title: "알림", message: msg, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction.init(title: "확인", style: UIAlertAction.Style.default) { (UIAlertAction) in
            alertVC.dismiss(animated: true) {
                
            }
        }
        
        alertVC.addAction(btnOK)
        
        self.present(alertVC, animated: true, completion: {
            
        })
        
    }
    
    func loadFile(_ url:URL) -> Void {
        let data = NSData.init(contentsOf: url)
        
        if(data?.isEmpty == true) {
            print("값이 없음")
        }else {
            print("값이 있음")
        }
        
    }
 
    
    // MARK: - UIDocumentPickerDelegate
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        DFT_TRACE_PRINT(output: "documentPicker")
        for url in urls {
            DFT_TRACE_PRINT(output: url.absoluteString)
            loadFile(url)
        }
        
        self.dismiss(animated: true) {
            
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        DFT_TRACE_PRINT(output: "documentPickerWasCancelled")
        
        self.dismiss(animated: true) {
            
        }
    }
}
