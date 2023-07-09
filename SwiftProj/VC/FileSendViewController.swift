//
//  FileSendViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/01/27.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

@objc(FileSendViewController)
class FileSendViewController: BasicViewController, UIDocumentInteractionControllerDelegate{

    var fileName : String!
    var docVC : UIDocumentInteractionController!
    
    @IBOutlet weak var imgV1: UIImageView!
    @IBOutlet weak var imgV2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url1 : URL = URL.init(fileURLWithPath: "https://garajilpung.synology.me/test/img/ty2.png");
        
        Utility .loadAsyncImageFromURL(pURL: url1, imageBlock: { (img) in
            self.imgV1.image = img
        }) {
            self.imgV1.image = nil
        }
        
        let url2 : URL = URL.init(fileURLWithPath: "https://garajilpung.synology.me/test/img/xx2.png");
        
        Utility .loadAsyncImageFromURL(pURL: url2, imageBlock: { (img) in
            self.imgV2.image = img
        }) {
            self.imgV2.image = nil
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

    @IBAction func onBtnDownload(_ sender: Any) {
//        let defaultConfig : URLSessionConfiguration = URLSessionConfiguration.default
//        let session : URLSession = URLSession.init(configuration: defaultConfig);
        let path = "https://garajilpung.synology.me/test/sample.pdf"
        
        let url = URL.init(string: path)
        let req = URLRequest.init(url: url!)
        
        let downTask = URLSession.shared.downloadTask(with: req) { (pUrl, pResp, error) in
            if(error != nil) {
                print("\(error!.localizedDescription)")
            }else {
                print("downlaodURL :[ \(pUrl!.absoluteString)]")
                
                let documentsURL : URL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("d.pdf")
                print("\(fileURL.absoluteString)")
                do {
                    try FileManager.default.removeItem(at: fileURL)
                    print("파일 삭제 성공.")
                }catch {
                    print("파일 삭제 실패.")
                    print(error)
                }
                
                do {
                    try FileManager.default.moveItem(at: pUrl!, to: fileURL)
                    print("파일 복사 성공.")
                    self.fileName = fileURL.absoluteString
                }catch{
                    print("파일 복사 실패.")
                    print(error)
                }
                    
            }
        }
        
        downTask.resume()
        
    }
    
    @IBAction func onBtnShare(_ sender: Any) {
        
        docVC = UIDocumentInteractionController(url: URL.init(fileURLWithPath: fileName))
        
        docVC.delegate = self
        docVC.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
    }
    
    @IBAction func onBtnShare2(_ sender: Any) {
        let url = NSURL.fileURL(withPath: fileName)
        
        let actVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        actVC.completionWithItemsHandler = { (activity, success, items, error) in
            if(success) {
                print("파일 복사 성공.")
            }else {
                print("파일 복사 실패.")
            }
        }
        
        self.present(actVC, animated: true)
        
    }
}
